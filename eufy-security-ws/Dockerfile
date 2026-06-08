ARG BUILD_FROM
FROM $BUILD_FROM

ARG EUFY_SECURITY_WS_VERSION

WORKDIR /usr/src/app
RUN \
    set -x \
    && apk add --no-cache jq \
    # Node.js 24.x is only available from the Alpine edge repositories
    # (the HA Alpine 3.20/3.21 base images ship Node 20/22). edge's Node is
    # built against OpenSSL 3.5, so the base's libcrypto3/libssl3 must be
    # upgraded from edge as well, otherwise node fails to relocate symbols
    # such as EVP_MD_CTX_get_size_ex at runtime.
    && apk upgrade --no-cache --available \
        --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
        libcrypto3 libssl3 \
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