#!/bin/ash -eu

abort () {
  echo "Error: $@" 1>&2
  exit 1
}

test -n "${SCHEDULE}" || abort '$SCHEDULE is not defined.'
test -n "${SCHEDULED_COMMAND}" || abort '$SCHEDULED_COMMAND is not defined.'
echo "${SCHEDULE} ${SCHEDULED_COMMAND}" > /etc/crontabs/root
crond -f -d ${CROND_LOG_LEVEL:-8} -c /etc/crontabs