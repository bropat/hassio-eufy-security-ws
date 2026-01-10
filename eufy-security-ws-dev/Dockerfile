ARG BUILD_FROM
FROM $BUILD_FROM

ARG EUFY_SECURITY_WS_VERSION

WORKDIR /usr/src/app
RUN chmod -R 777 /usr/src/app
RUN \
    set -x \
    $$ mkdir /usr/src/app/eufy-temp \
    && apk add --no-cache \
    nodejs \
    npm \
    jq \
    git \
    && npm install --force \
    "eufy-security-ws@${EUFY_SECURITY_WS_VERSION}"
COPY package.json /usr/src/app/eufy-temp/

COPY run.sh /
RUN chmod a+x /run.sh
WORKDIR /data


CMD [ "/run.sh" ]
