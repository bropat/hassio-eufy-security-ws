ARG BUILD_FROM
FROM $BUILD_FROM

ARG EUFY_SECURITY_WS_VERSION

WORKDIR /usr/src/app
RUN \
    set -x \
    && apk add --no-cache jq \
    # Node.js 24.x is only available from the Alpine edge repositories
    # (the HA Alpine 3.20/3.21 base images ship Node 20/22).
    && apk add --no-cache \
        --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
        --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
        nodejs \
        npm \
    && node --version \
    && npm install --force \
    "eufy-security-ws@${EUFY_SECURITY_WS_VERSION}"

COPY run.sh /
RUN chmod a+x /run.sh
WORKDIR /data

CMD [ "/run.sh" ]