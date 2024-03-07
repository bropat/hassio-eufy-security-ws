#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/eufy-security-ws-config.json

USERNAME="$(bashio::config 'username')"
PASSWORD="$(bashio::config 'password')"
COUNTRY="$(bashio::config 'country')"
EVENT_DURATION_SECONDS="$(bashio::config 'event_duration')"
POLLING_INTERVAL_MINUTES="$(bashio::config 'polling_interval')"
ACCEPT_INVITATIONS="$(bashio::config 'accept_invitations')"
TRUSTED_DEVICE_NAME="$(bashio::config 'trusted_device_name')"

COUNTRY_JQ=""
if bashio::config.has_value 'country'; then
    COUNTRY_JQ="country: \$country,"
fi

EVENT_DURATION_SECONDS_JQ=""
if bashio::config.has_value 'event_duration'; then
    EVENT_DURATION_SECONDS_JQ="eventDurationSeconds: \$event_duration_seconds|tonumber,"
fi

POLLING_INTERVAL_MINUTES_JQ=""
if bashio::config.has_value 'polling_interval'; then
    POLLING_INTERVAL_MINUTES_JQ="pollingIntervalMinutes: \$polling_interval_minutes|tonumber,"
fi

ACCEPT_INVITATIONS_JQ=""
if bashio::config.true 'accept_invitations'; then
    ACCEPT_INVITATIONS_JQ="acceptInvitations: \$accept_invitations,"
fi

TRUSTED_DEVICE_NAME_JQ=""
if bashio::config.has_value 'trusted_device_name'; then
    TRUSTED_DEVICE_NAME_JQ="trustedDeviceName: \$trusted_device_name,"
fi

STATION_IP_ADDRESSES_ARG=""
STATION_IP_ADDRESSES_JQ=""
if bashio::config.has_value 'stations'; then
    while read -r data
    do
        TMP_DATA=($(echo "${data}" | tr -d "{}\"[:blank:]" | tr "," " " | sed 's/serial_number://g;s/ip_address://g'))
        if [ "$STATION_IP_ADDRESSES_ARG" = "" ]; then
            STATION_IP_ADDRESSES_ARG="--arg ${TMP_DATA[0]} ${TMP_DATA[1]}"
            STATION_IP_ADDRESSES_JQ="stationIPAddresses: { \$${TMP_DATA[0]}"
        else
            STATION_IP_ADDRESSES_ARG="$STATION_IP_ADDRESSES_ARG --arg ${TMP_DATA[0]} ${TMP_DATA[1]}"
            STATION_IP_ADDRESSES_JQ="$STATION_IP_ADDRESSES_JQ, \$${TMP_DATA[0]}"
        fi
    done <<<"$(bashio::config 'stations')"
    if [ "$STATION_IP_ADDRESSES_ARG" != "" ]; then
        STATION_IP_ADDRESSES_JQ="$STATION_IP_ADDRESSES_JQ }"
    fi
    #bashio::log.info "STATION_IP_ADDRESSES_JQ: ${STATION_IP_ADDRESSES_JQ}"
    #bashio::log.info "STATION_IP_ADDRESSES_ARG: ${STATION_IP_ADDRESSES_ARG}"
fi

PORT_OPTION=""
if bashio::config.has_value 'port'; then
    PORT_OPTION="--port $(bashio::config 'port')"
fi

DEBUG_OPTION=""
if bashio::config.true 'debug'; then
    DEBUG_OPTION="-v"
fi

IPV4_FIRST_NODE_OPTION=""
if bashio::config.true 'ipv4first'; then
    IPV4_FIRST_NODE_OPTION="--dns-result-order=ipv4first"
fi

JSON_STRING="$( jq -n \
  --arg username "$USERNAME" \
  --arg password "$PASSWORD" \
  --arg country "$COUNTRY" \
  --arg event_duration_seconds "$EVENT_DURATION_SECONDS" \
  --arg polling_interval_minutes "$POLLING_INTERVAL_MINUTES" \
  --arg trusted_device_name "$TRUSTED_DEVICE_NAME" \
  --arg accept_invitations "$ACCEPT_INVITATIONS" \
  $STATION_IP_ADDRESSES_ARG \
    "{
      username: \$username,
      password: \$password,
      persistentDir: \"/data\",
      $COUNTRY_JQ
      $EVENT_DURATION_SECONDS_JQ
      $POLLING_INTERVAL_MINUTES_JQ
      $TRUSTED_DEVICE_NAME_JQ
      $ACCEPT_INVITATIONS_JQ
      $STATION_IP_ADDRESSES_JQ
    }"
  )"

check_version() {
    if [ "$1" = "$2" ]; then
        return 1 # equal
    fi
    version=$(printf '%s\n' "$1" "$2" | sort -V | tail -n 1)
    if [ "$version" = "$2" ]; then
        return 2 # greater
    fi
    return 0 # lower
}

node_version=$(node -v)
node_result=0
if [ "${node_version:1:2}" = "18" ]; then
    check_version "v18.19.1" "$node_version"
    node_result=$?
elif [ "${node_version:1:2}" = "20" ]; then
    check_version "v20.11.1" "$node_version"
    node_result=$?
else
    check_version "v21.6.2" "$node_version"
    node_result=$?
fi
WORKAROUND_ISSUE_310=""
if [ $node_result -gt 0 ]; then
    WORKAROUND_ISSUE_310="--security-revert=CVE-2023-46809"
fi

if bashio::config.has_value 'username' && bashio::config.has_value 'password'; then
    echo "$JSON_STRING" > $CONFIG_PATH
    exec /usr/bin/node $WORKAROUND_ISSUE_310 $IPV4_FIRST_NODE_OPTION /usr/src/app/node_modules/eufy-security-ws/dist/bin/server.js --host 0.0.0.0 --config $CONFIG_PATH $DEBUG_OPTION $PORT_OPTION
else
    echo "Required parameters username and/or password not set. Starting aborted!"
fi

