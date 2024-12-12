#!/bin/bash

set -e

if [ -n "${CSR_ATTRIBUTES}" ]; then
    echo "CSR Attributes: ${CSR_ATTRIBUTES}"
    /opt/puppetlabs/puppet/bin/ruby /docker-entrypoint.d/89-csr_attributes.rb
fi
