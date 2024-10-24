#!/bin/bash

set -e

hocon() {
  /opt/puppetlabs/puppet/lib/ruby/vendor_gems/bin/hocon "$@"
}

if test -n "$PUPPETSERVER_PORT"; then
  cd /etc/puppetlabs/puppetserver/conf.d/
  hocon -f webserver.conf set webserver.ssl-port $PUPPETSERVER_PORT
  cd /etc/puppetlabs/puppet/
  hocon -f puppet.conf set serverport $PUPPETSERVER_PORT
  cd /
fi
