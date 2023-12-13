#!/bin/bash
#
if [[ "$PUPPETSERVER_ENABLE_ENV_CACHE_DEL_API" == true ]]; then
  /opt/puppetlabs/puppet/bin/ruby /add_cache_del_api_auth_rules.rb
fi
