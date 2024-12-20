#!/bin/bash

set -e

if [ -n "${PUPPETSERVER_HOSTNAME}" ]; then
  /usr/bin/puppet config set server "$PUPPETSERVER_HOSTNAME"
fi

if [ -n "${CERTNAME}" ]; then
  /usr/bin/puppet config set certname "$CERTNAME"
fi
