#!/usr/bin/env bash

set -x
set -e

timeout=10
if [ "$#" -gt 0 ]; then
  timeout=$1
fi

certname=$(cd "${SSLDIR}/certs" && ls *.pem | grep --invert-match ca.pem)

curl --fail \
    --no-progress-meter \
    --max-time ${timeout} \
    --resolve "${HOSTNAME}:${PUPPETSERVER_PORT:-8140}:127.0.0.1" \
    --cert    "${SSLDIR}/certs/$certname" \
    --key     "${SSLDIR}/private_keys/$certname" \
    --cacert  "${SSLDIR}/certs/ca.pem" \
    "https://${HOSTNAME}:${PUPPETSERVER_PORT:-8140}/status/v1/simple" \
    |  grep -q '^running$' \
    || exit 1
