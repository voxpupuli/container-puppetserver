#!/bin/sh

set -e

if [ -n "$PUPPET_STORECONFIGS_BACKEND" ]; then
  puppet config set storeconfigs_backend $PUPPET_STORECONFIGS_BACKEND --section server
fi

if [ -n "$PUPPET_STORECONFIGS" ]; then
  puppet config set storeconfigs $PUPPET_STORECONFIGS --section server
fi

if [ -n "$PUPPET_REPORTS" ]; then
  puppet config set reports $PUPPET_REPORTS --section server
fi

# reset defaults if USE_PUPPETDB is false, but don't overwrite custom settings
if [ "$USE_PUPPETDB" = 'false' ]; then
  if [ "$PUPPET_REPORTS" = 'puppetdb' ]; then
    puppet config set reports log --section server
  fi

  if [ "$PUPPET_STORECONFIGS_BACKEND" = 'puppetdb' ]; then
    puppet config set storeconfigs false --section server
  fi
fi
