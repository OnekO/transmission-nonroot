FROM alpine:3.20

ENV TRANSMISSION_HOME=/config \
    TRANSMISSION_WEB_HOME=/config/flood-for-transmission \
    PUID=1000 \
    PGID=1000 \
    TZ=Europe/Madrid

RUN addgroup -g 1000 abc && \
    adduser -D -u 1000 -G abc abc

RUN apk add --no-cache transmission-daemon curl tar tzdata su-exec

RUN mkdir -p /config /downloads /watch /config/flood-for-transmission && \
    chown -R abc:abc /config /downloads /watch

RUN curl -sL https://github.com/johman10/flood-for-transmission/releases/latest/download/flood-for-transmission.tar.gz | \
    tar xz -C /config/flood-for-transmission

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER abc
WORKDIR /config
VOLUME ["/config", "/downloads", "/watch"]

EXPOSE 9091 51413 51413/udp 50000 50000/udp

ENTRYPOINT ["/entrypoint.sh"]
