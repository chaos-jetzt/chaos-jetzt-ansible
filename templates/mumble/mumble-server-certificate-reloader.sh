#!/usr/bin/env bash
if ${DEBUG:-false}; then
  set -x
fi
set -E

hostname=${1:-mumble.chaos.jetzt}
port=${2:-64738}
murmur_pid=$(cat /var/run/mumble-server/mumble-server.pid)
reload_cmd=${3:-"kill -10 $murmur_pid"}
now=$(date +"%s")
in_one_week=$((now + 60*60*24*7))
${DRY_RUN:=false}

# Checking if the certificate will expire in one week or less
echo | openssl s_client -connect "${hostname}:${port}" -servername "${hostname}" -servername mumble.chaos.jetzt -attime ${in_one_week} -verify_return_error -verify 20 >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  echo "Reloading..."
  if ! $DRY_RUN; then
    $reload_cmd
  fi
fi
