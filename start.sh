#!/bin/bash

if [[ ! -e utserver ]]
then
    echo 'Downloading utorrent server...'
    wget -qO - http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0 | tar xzf - --strip-components 1
fi

if [[ ! -e /settings/webui.zip ]]
then
    echo 'Symlinking webui.zip to /settings...'
    ln -s /utorrent/webui.zip /settings/webui.zip
fi

echo 'Starting utorrent server...'
exec ./utserver -settingspath /settings -logfile /settings/utserver.log
