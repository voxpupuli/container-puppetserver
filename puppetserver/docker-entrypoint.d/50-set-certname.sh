#!/bin/bash

if [ -n "${PUPPETSERVER_HOSTNAME}" ]; then
  /opt/puppetlabs/bin/puppet config set server "$PUPPETSERVER_HOSTNAME"
fi

if [ -n "${CERTNAME}" ]; then
  /opt/puppetlabs/bin/puppet config set certname "$CERTNAME"
fi
