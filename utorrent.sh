#!/bin/bash

#
# Display settings on standard out.
#

USER="utorrent"

echo "-> Initializing......"
echo "==========================================================="
echo "-> utorrent settings:"
echo "==========================================================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${UTORRENT_UID:=666}"
echo "  GID:        ${UTORRENT_GID:=666}"
echo ""

#
# Symlinking webui.zip to settings path.
#

if [[ ! -e /utorrent/settings/webui.zip ]]
then
    printf 'MSG: Symlinking webui.zip to /settings...'
    ln -s /utorrent/webui.zip /utorrent/settings/webui.zip
    echo "MSG: [DONE]"
fi

#
# Finally, start utorrent.
#

echo ""
echo '-> Starting utorrent server......'
exec su -pc "./utserver -settingspath /utorrent/settings -configfile /utorrent/settings/utserver.conf -logfile /utorrent/settings/utserver.log" ${USER}
echo '#################################### UTSERVER ####################################'
