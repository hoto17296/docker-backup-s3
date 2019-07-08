#!/bin/ash -eu

abort () {
  echo "Error: $@" 1>&2
  exit 1
}

if [ -n "${TZ}" ]; then
  test -f /usr/share/zoneinfo/${TZ} || abort "Invalid timezone '${TZ}'"
  cp /usr/share/zoneinfo/${TZ} /etc/localtime
  echo ${TZ} > /etc/timezone
fi

exec $@