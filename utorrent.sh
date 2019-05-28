#!/bin/bash

#
# Display settings on standard out.
#

USER="utorrent"

echo "-> Initializing......"
echo "-> utorrent settings:"
echo "==========================================================="
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
    printf 'MSG: Symlinking webui.zip to /settings...'
    ln -s /utorrent/webui.zip /settings/webui.zip
    echo "MSG: [DONE]"
fi

#
# Finally, start utorrent.
#

echo
echo '-> Starting utorrent server......'
exec su -pc "./utserver -settingspath /settings -configfile /settings/utserver.conf -logfile /settings/utserver.log" ${USER}
echo '#################################### UTSERVER ####################################'
