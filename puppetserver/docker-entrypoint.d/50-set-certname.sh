#!/bin/bash

set -e

if [ -n "${PUPPETSERVER_HOSTNAME}" ]; then
  puppet config set server "$PUPPETSERVER_HOSTNAME"
fi

if [ -n "${CERTNAME}" ]; then
  puppet config set certname "$CERTNAME"
fi
