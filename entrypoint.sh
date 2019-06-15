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

case "$1" in
  cron)
    test -n "${SCHEDULE}" || abort '$SCHEDULE is not defined.'
    CRON_DIR='/etc/crontabs'
    echo "${SCHEDULE} sh /sync.sh" > ${CRON_DIR}/root
    crond -f -d ${CROND_LOG_LEVEL:-8} -c ${CRON_DIR}
    ;;

  sync)
    sh /sync.sh
    ;;

  *)
    $@
    ;;
esac
