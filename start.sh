#!/bin/bash

# Download new utorrent server.
echo 'Downloading new utorrent server...'
wget -q /tmp/utserver.tar.gz http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0 \
    && rm -rf * \
    && tar xzf /tmp/utserver.tar.gz --strip-components 1

# Symlink webui.zip.
echo
echo 'Symlinking webui.zip to /settings...'
ln -sf /utorrent/webui.zip /settings/webui.zip

# Start utorrent.
echo
echo 'Starting utorrent server...'
./utserver -settingspath /settings -logfile /settings/utserver.log
