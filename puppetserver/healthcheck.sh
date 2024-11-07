#!/usr/bin/env bash

set -x
set -e

timeout=10

if [ "$#" -gt 0 ]; then
  timeout=$1
fi

curl --fail \
    --no-progress-meter \
    --max-time ${timeout} \
    --resolve "${HOSTNAME}:${PUPPETSERVER_PORT:-8140}:127.0.0.1" \
    --cert     $(puppet config print hostcert) \
    --key      $(puppet config print hostprivkey) \
    --cacert   $(puppet config print localcacert) \
    "https://${HOSTNAME}:${PUPPETSERVER_PORT:-8140}/status/v1/simple" \
    |  grep -q '^running$' \
    || exit 1
