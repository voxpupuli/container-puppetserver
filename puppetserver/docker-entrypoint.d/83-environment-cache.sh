#!/bin/bash
#
if [ -n "$PUPPETSERVER_ENVIRONMENT_TIMEOUT" ]; then
  echo "Settings environment_timeout to ${PUPPETSERVER_ENVIRONMENT_TIMEOUT}"
  puppet config set --section master environment_timeout $PUPPETSERVER_ENVIRONMENT_TIMEOUT
else
  echo "Removing environment_timeout"
  puppet config delete --section master environment_timeout
fi

