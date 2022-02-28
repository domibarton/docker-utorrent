FROM ubuntu:18.04
LABEL Maintainer="Yuri L Chuk"

ARG CONFD_VERSION=0.16.0

#
# Create user and group for utorrent.
#
RUN set -eux; \
    echo '--> User Setup'; \
    groupadd --gid 1001 utorrent; \
    useradd --uid 1001 --gid utorrent --groups tty --home-dir /utorrent --create-home --shell /bin/bash utorrent;

#
# Install utorrent and all required dependencies.
#
RUN echo '--> Installing packages and utserver...'; \
    apt-get update; \
    apt-get install -qy curl sudo openssl libssl1.0.0 libssl-dev vim nfs-common; \
    curl -s http://download-new.utorrent.com/endpoint/utserver/os/linux-x64-ubuntu-13-04/track/beta/ | tar xzf - --strip-components 1 -C utorrent; \
    apt-get -y autoremove; \
    apt-get -y clean; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/cache/apt/*; \
    echo '--> Setup confd'; \
    curl -fSL --output /confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64; \
    chmod +x /confd; \
    echo '--> Make dirs'; \
    mkdir \
        /utorrent/shared/download \
        /utorrent/shared/torrent \
        /utorrent/shared/done \
        /utorrent/settings \
        /utorrent/temp; \
    chown -R utorrent:utorrent /utorrent;

#
# Add config file.
#
ADD utserver.conf /utorrent/shared/utserver.conf
RUN set -eux; \
    echo '--> Adding Configs'; \
    chmod +x /utorrent/shared/utserver.conf

#
# Copy confd configs and templates
#
ADD --chown=utorrent:utorrent confd/ /etc/confd/

#
# Add utorrent init script.
#
ADD --chown=utorrent:utorrent utorrent.sh /
RUN set -eux; chmod +x /utorrent.sh

WORKDIR /utorrent

#
# Start utorrent.
#
ENTRYPOINT ["/utorrent.sh"]
CMD ["/utorrent/utserver", "-settingspath", "/utorrent/settings", "-configfile", "/utorrent/shared/utserver.conf", "-logfile", "/dev/stdout"]