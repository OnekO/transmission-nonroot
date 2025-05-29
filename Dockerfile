FROM alpine:3.20

ENV PUID=1000 \
    PGID=1000 \
    TZ=Europe/Madrid \
    TRANSMISSION_WEB_HOME=/config/flood-for-transmission \
    TRANSMISSION_HOME=/config \
    TRANSMISSION_DOWNLOAD_DIR=/downloads/complete \
    TRANSMISSION_INCOMPLETE_DIR_ENABLED=true \
    TRANSMISSION_INCOMPLETE_DIR=/downloads/incomplete \
    TRANSMISSION_WATCH_DIR_ENABLED=false \
    TRANSMISSION_WATCH_DIR=/watch \
    TRANSMISSION_RPC_PASSWORD=transmission \
    TRANSMISSION_RPC_USERNAME=admin \
    TRANSMISSION_RPC_AUTH=true \
    TRANSMISSION_RPC_PORT=9091 \
    TRANSMISSION_PEER_PORT=51413

RUN addgroup -g ${PGID} abc && \
    adduser -D -u ${PUID} -G abc abc

RUN apk add --no-cache transmission-daemon curl tar tzdata bash gettext

RUN mkdir -p /config /downloads/complete /downloads/incomplete /watch /config/flood-for-transmission && \
    chown -R abc:abc /config /downloads /watch

RUN curl -sL https://github.com/johman10/flood-for-transmission/releases/latest/download/flood-for-transmission.tar.gz | \
    tar xz -C /config/flood-for-transmission

COPY entrypoint.sh /entrypoint.sh
COPY settings.json.template /defaults/settings.json.template

RUN chmod +x /entrypoint.sh

USER abc
WORKDIR /config

VOLUME ["/config", "/downloads", "/watch"]

EXPOSE 9091 51413 51413/udp 50000 50000/udp

ENTRYPOINT ["/entrypoint.sh"]
