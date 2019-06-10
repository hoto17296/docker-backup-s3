abort () {
  echo "Error: $@" 1>&2
  exit 1
}

case "$1" in
  cron)
    test -n "${SCHEDULE}" || abort '$SCHEDULE is not defined.'
    CRON_DIR='/etc/crontabs'
    FD='/proc/$(cat /var/run/crond.pid)/fd'
    echo "${SCHEDULE} sh /sync.sh 1> ${FD}/1 2> ${FD}/2" > ${CRON_DIR}/root
    crond -f -d ${CROND_LOG_LEVEL:-8} -c ${CRON_DIR}
    ;;

  sync)
    sh /sync.sh
    ;;

  *)
    $@
    ;;
esac
