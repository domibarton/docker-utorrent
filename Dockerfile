FROM debian:8
MAINTAINER Dominique Barton

RUN apt-get -q update \
    && apt-get install -qy wget libssl1.0.0 \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN groupadd -r -g 666 utorrent \
    && useradd -r -u 666 -g 666 -d /utorrent -m utorrent

ADD start.sh /start.sh
RUN chown utorrent: /start.sh \
    && chmod 755 /start.sh

VOLUME ["/settings", "/media"]

EXPOSE 8080 6881

USER utorrent

WORKDIR /utorrent
CMD ["/start.sh"]
