ARG BUILD_FROM
FROM $BUILD_FROM

ARG EUFY_SECURITY_WS_VERSION

WORKDIR /usr/src/app
RUN \
    set -x \
    && echo "@edge https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk add --no-cache \
        nodejs@edge \
        npm \
        jq \
    && npm install --force \
        "eufy-security-ws@${EUFY_SECURITY_WS_VERSION}"

COPY run.sh /
RUN chmod a+x /run.sh
WORKDIR /data

CMD [ "/run.sh" ]