ARG BUILD_FROM
ARG RUNTIME_FROM
ARG EUFY_SECURITY_WS_VERSION

FROM $BUILD_FROM AS build

WORKDIR /tmp

RUN \
    set -x \
    && apk add --no-cache \
    nodejs \
    npm \
    jq \
    && npm install --force \
    "eufy-security-ws@${EUFY_SECURITY_WS_VERSION}"

FROM $RUNTIME_FROM

WORKDIR /usr/src/app
RUN \
    set -x \
    && apk add --no-cache \
    nodejs \
    npm \
    jq

COPY --from=build /tmp ./
COPY run.sh /
RUN chmod a+x /run.sh
WORKDIR /data

CMD [ "/run.sh" ]