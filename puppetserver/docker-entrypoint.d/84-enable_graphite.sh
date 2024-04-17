#!/bin/bash

set -e

if [[ "$PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED" == "true" ]]; then
  if [[ -n "$PUPPETSERVER_GRAPHITE_HOST" && -n "$PUPPETSERVER_GRAPHITE_PORT" ]]; then
    echo "Enabling graphite exporter"
    sed -e "s/GRAPHITE_HOST/$PUPPETSERVER_GRAPHITE_HOST/" -e "s/GRAPHITE_PORT/$PUPPETSERVER_GRAPHITE_PORT/" /metrics.conf.tmpl > /etc/puppetlabs/puppetserver/conf.d/metrics.conf
  else
    echo "ERROR: no PUPPETSERVER_GRAPHITE_HOST or PUPPETSERVER_GRAPHITE_PORT set."
    exit 99
  fi
fi
