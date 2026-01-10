ARG BUILD_FROM
FROM $BUILD_FROM

ARG EUFY_SECURITY_WS_VERSION

WORKDIR /usr/src/app
RUN chmod -R 777 /usr/src/app
RUN \
    set -x \
    && apk add --no-cache \
    nodejs \
    npm \
    jq \
    git \
    && whoami > best \
    && npm install --force \
    "eufy-security-ws@${EUFY_SECURITY_WS_VERSION}"
COPY package.json /usr/src/app/
RUN chown root:root /usr/src/app/package.json
RUN chmod 777 /usr/src/app/package.json

COPY run.sh /
RUN chmod a+x /run.sh
WORKDIR /data


CMD [ "/run.sh" ]
