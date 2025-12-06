ARG BUILD_FROM
FROM $BUILD_FROM

ARG EUFY_SECURITY_WS_VERSION
ARG EUFY_SECURITY_CLIENT_GIT

WORKDIR /usr/src/app
RUN \
    set -x \
    && apk add --no-cache \
    nodejs \
    npm \
    jq \
    && if [ -n "$EUFY_SECURITY_CLIENT_GIT" ]; then \
         npm init -y \
         && npm pkg set name="hassio-eufy-security-ws" \
         && npm pkg set private=true \
         && npm pkg set dependencies.eufy-security-ws="$EUFY_SECURITY_WS_VERSION" \
         && npm pkg set overrides.eufy-security-client="$EUFY_SECURITY_CLIENT_GIT" \
         && npm install --force; \
       else \
         npm install --force "eufy-security-ws@${EUFY_SECURITY_WS_VERSION}"; \
       fi

COPY run.sh /
RUN sed -i 's/\r$//' /run.sh && chmod a+x /run.sh
WORKDIR /data

CMD [ "/run.sh" ]
