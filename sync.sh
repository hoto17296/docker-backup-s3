#!/bin/ash -eu

build_file_opts () {
  test -n "$2" || return
  echo "$1 "$(echo "$2" | sed -e "s/, */ $1 /g")
}

aws s3 sync \
  /src \
  ${S3_URL} \
  $(build_file_opts '--include' "${INCLUDE_FILES}") \
  $(build_file_opts '--exclude' "${EXCLUDE_FILES}") \
  ${SYNC_OPTIONS}

