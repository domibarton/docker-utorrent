FROM debian:8
MAINTAINER Dominique Barton

#
# Create user and group for utorrent.
#

RUN groupadd -r -g 666 utorrent \
    && useradd -r -u 666 -g 666 -d /utorrent -m utorrent

#
# Add utorrent init script.
#

ADD utorrent.sh /utorrent.sh
RUN chown utorrent: /utorrent.sh \
    && chmod 755 /utorrent.sh

#
# Install utorrent and all required dependencies.
#

RUN apt-get -q update \
    && apt-get install -qy curl libssl1.0.0 \
    && curl -s http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0 | tar xzf - --strip-components 1 -C utorrent \
    && chown -R utorrent: utorrent \
    && apt-get -y remove curl \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

#
# Define container settings.
#

VOLUME ["/settings", "/media"]

EXPOSE 8080 6881

#
# Start utorrent.
#

WORKDIR /utorrent

CMD ["/utorrent.sh"]
