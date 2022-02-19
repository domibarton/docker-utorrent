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
# Symlinking webui.zip to shared path.
#
if [[ ! -e /utorrent/shared/webui.zip ]]
then
    echo 'MSG: Symlinking webui.zip to /shared...'
    ln -s /utorrent/webui.zip /utorrent/shared/webui.zip
    echo "MSG: [DONE]"
fi

#
# Symlinking tserver.conf to shared path.
#
if [[ ! -e /utorrent/shared/utserver.conf ]]
then
    echo 'MSG: Symlinking utserver.conf to /shared...'
    ln -s /utorrent/utserver.conf /utorrent/shared/utserver.conf
    echo "MSG: [DONE]"
fi

#
# Create download folder.
#
if [ ! -d /utorrent/shared/download ]; 
then
  echo 'Create download folder...'
  mkdir -p /utorrent/shared/download;
fi

#
# Create done folder.
#
if [ ! -d /utorrent/shared/done ]; 
then
  echo 'Create done folder...'
  mkdir -p /utorrent/shared/done;
fi

#
# Create torrent folder.
#
if [ ! -d /utorrent/torrent ]; 
then
  echo 'Create torrent folder...'
  mkdir -p /utorrent/shared/torrent;
fi

echo 'Set Permission to folder...'
chmod -R 777 /utorrent;

#
# Finally, start utorrent.
#
echo " "
echo '-> Starting utorrent server......'
exec su -pc "./utserver -configfile /utorrent/shared/utserver.conf -logfile /utorrent/shared/utserver.log" ${USER}
echo '#################################### UTSERVER ####################################'
