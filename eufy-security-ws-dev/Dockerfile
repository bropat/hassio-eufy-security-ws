ARG BUILD_FROM
FROM $BUILD_FROM

ARG EUFY_SECURITY_WS_VERSION

WORKDIR /usr/src/app
RUN \
    set -x \
    && apk add --no-cache \
    nodejs \
    npm \
    jq \
    git \
    && npm install --force \
    "eufy-security-ws@${EUFY_SECURITY_WS_VERSION}"
COPY package.json /usr/src/app/

COPY run.sh /
RUN chmod a+x /run.sh
WORKDIR /data


CMD [ "/run.sh" ]
