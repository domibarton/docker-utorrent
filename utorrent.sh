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
echo " "

#
# Symlinking webui.zip to settings path.
#

if [[ ! -e /utorrent/webui.zip ]]
then
    echo 'MSG: Symlinking webui.zip to /settings...'
    ln -s /utorrent/webui.zip /utorrent/webui.zip
    echo "MSG: [DONE]"
fi

if [[ ! -e /utorrent/utserver.conf ]]
then
    echo 'MSG: Symlinking utserver.conf to /settings...'
    ln -s /utorrent/utserver.conf /utorrent/utserver.conf
    echo "MSG: [DONE]"
fi

#
# Finally, start utorrent.
#

echo " "
echo '-> Starting utorrent server......'
exec su -pc "./utserver -configfile /utorrent/utserver.conf -logfile /utorrent/utserver.log" ${USER}
echo '#################################### UTSERVER ####################################'
