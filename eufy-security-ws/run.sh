#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/eufy-security-ws-config.json

USERNAME="$(bashio::config 'username')"
PASSWORD="$(bashio::config 'password')"

COUNTRY_ARG=""
COUNTRY_JQ=""
if bashio::config.has_value 'country'; then
    COUNTRY_ARG="--arg country $(bashio::config 'country')"
    COUNTRY_JQ="country: \$country,"
fi

EVENT_DURATION_SECONDS_ARG=""
EVENT_DURATION_SECONDS_JQ=""
if bashio::config.has_value 'event_duration'; then
    EVENT_DURATION_SECONDS_ARG="--arg event_duration_seconds $(bashio::config 'event_duration' '')"
    EVENT_DURATION_SECONDS_JQ="eventDurationSeconds: \$event_duration_seconds,"
fi

LANGUAGE_ARG=""
LANGUAGE_JQ=""
#if bashio::config.has_value 'language'; then
#    LANGUAGE_ARG="--arg language $(bashio::config 'language')"
#    LANGUAGE_JQ="language: \$language,"
#fi

P2P_CONNECTION_SETUP_ARG=""
P2P_CONNECTION_SETUP_JQ=""
#if [ -n "${P2P_CONNECTION_SETUP}" ]; then
#    P2P_CONNECTION_SETUP_ARG="--arg p2p_connection_setup $P2P_CONNECTION_SETUP"
#    P2P_CONNECTION_SETUP_JQ="p2pConnectionSetup: \$p2p_connection_setup,"
#fi

POLLING_INTERVAL_MINUTES_ARG=""
POLLING_INTERVAL_MINUTES_JQ=""
if bashio::config.has_value 'polling_interval'; then
    POLLING_INTERVAL_MINUTES_ARG="--arg polling_interval_minutes $(bashio::config 'polling_interval')"
    POLLING_INTERVAL_MINUTES_JQ="pollingIntervalMinutes: \$polling_interval_minutes,"
fi

ACCEPT_INVITATIONS_ARG=""
ACCEPT_INVITATIONS_JQ=""
if bashio::config.true 'accept_invitations'; then
    ACCEPT_INVITATIONS_ARG="--arg accept_invitations $(bashio::config 'accept_invitations')"
    ACCEPT_INVITATIONS_JQ="acceptInvitations: \$accept_invitations,"
fi

TRUSTED_DEVICE_NAME_ARG=""
TRUSTED_DEVICE_NAME_JQ=""
if bashio::config.has_value 'trusted_device_name'; then
    TRUSTED_DEVICE_NAME_ARG="--arg trusted_device_name $(bashio::config 'trusted_device_name')"
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
    PORT_OPTION="--port $(bashio::config 'port' '3000')"
fi

DEBUG_OPTION=""
if bashio::config.true 'debug'; then
    DEBUG_OPTION="-v"
fi

JSON_STRING="$( jq -n \
  --arg username "$USERNAME" \
  --arg password "$PASSWORD" \
  $COUNTRY_ARG \
  $EVENT_DURATION_SECONDS_ARG \
  $LANGUAGE_ARG \
  $P2P_CONNECTION_SETUP_ARG \
  $POLLING_INTERVAL_MINUTES_ARG \
  $TRUSTED_DEVICE_NAME_ARG \
  $ACCEPT_INVITATIONS_ARG \
  $STATION_IP_ADDRESSES_ARG \
    "{
      username: \$username,
      password: \$password,
      persistentDir: \"/data\",
      $COUNTRY_JQ
      $EVENT_DURATION_SECONDS_JQ
      $LANGUAGE_JQ
      $P2P_CONNECTION_SETUP_JQ
      $POLLING_INTERVAL_MINUTES_JQ
      $TRUSTED_DEVICE_NAME_JQ
      $ACCEPT_INVITATIONS_JQ
      $STATION_IP_ADDRESSES_JQ
    }"
  )"

if bashio::config.has_value 'username' && bashio::config.has_value 'password'; then
    echo "$JSON_STRING" > $CONFIG_PATH
fi

/usr/bin/node /usr/src/app/node_modules/eufy-security-ws/dist/bin/server.js --host 0.0.0.0 --config $CONFIG_PATH $DEBUG_OPTION $PORT_OPTION