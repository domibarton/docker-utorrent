#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
  DEBUG_FIND="-print"
  CONFD_LOGLEVEL="-log-level debug"
fi

#
# Display settings on standard out.
#

echo "-> Initializing......"
echo "==========================================================="
echo "-> utorrent settings:"
echo "==========================================================="
echo
echo " "

CURRENT_UID=$(id -u)
if [[ ${CURRENT_UID} != 0 ]]; then
    echo "[WARN] Host UID/GID usage disabled because the container is not running under the root (current uid: ${CURRENT_UID})"
    exec "$@"
    exit
fi

# we find the host uid/gid by assuming the app directory belongs to the host
if [ -z "${UID}" ]; then
  UID=$(stat -c %u /utorrent)
fi
if [ -z "${GID}" ]; then
  GID=$(stat -c %g /utorrent)
fi

DO_CHOWN=0

# If the docker user doesn't share the same uid, change it so that it does
if [[ ${UID}  -ne $(id -u utorrent) ]] && [[ ${UID} != 0 ]]; then
  echo "[$(date -u "+%FT%TZ")] Data dir owner does not met utorrent user"
  echo "[$(date -u "+%FT%TZ")] Changing utorrent user UID to ${UID}"
  usermod -o -u ${UID} utorrent
  DO_CHOWN=1
fi

if [[ ${GID} -ne $(id -g utorrent) ]] && [[ ${GID} != 0 ]]; then
  echo "[$(date -u "+%FT%TZ")] Data dir group does not met utorrent user group"
  echo "[$(date -u "+%FT%TZ")] Changing utorrent user group GID to ${GID}"
  groupmod -o -g ${GID} utorrent
  DO_CHOWN=1
fi

# also update the file uid/gid for files in the docker home directory
# skip the mounted "app" dir because we don't want any changes to mounted file ownership
if [[ ${DO_CHOWN} -ne 0 ]]; then
  echo "[$(date -u "+%FT%TZ")] Changing ownership of /utorrent dir"
  find /utorrent -not \( -user utorrent -group utorrent \) ${DEBUG_FIND} -exec chown -R utorrent:utorrent {} \;
fi

#
# Finally, start utorrent.
#
echo " "
echo '-> Starting utorrent server......'
sudo -E -u utorrent -g utorrent -- /confd -onetime -backend env ${CONFD_LOGLEVEL} || exit 13
exec sudo -E -u utorrent -g utorrent -- "$@"
echo '#################################### UTSERVER ####################################'