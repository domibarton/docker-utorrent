#!/bin/bash

#
# Display settings on standard out.
#

USER="utorrent"

echo "utorrent settings"
echo "================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${UTORRENT_UID:=666}"
echo "  GID:        ${UTORRENT_GID:=666}"
echo

#
# Symlinking webui.zip to settings path.
#

if [[ ! -e /settings/webui.zip ]]
then
    printf 'Symlinking webui.zip to /settings...'
    ln -s /utorrent/webui.zip /settings/webui.zip
    echo "[DONE]"
fi

#
# Finally, start utorrent.
#

echo 'Starting utorrent server...'
exec su -pc "./utserver -settingspath /settings -logfile /settings/utserver.log" ${USER}
