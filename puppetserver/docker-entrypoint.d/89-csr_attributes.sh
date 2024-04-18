#!/bin/bash

set -e

echo "CSR Attributes: ${CSR_ATTRIBUTES}"
/opt/puppetlabs/puppet/bin/ruby /docker-entrypoint.d/89-csr_attributes.rb
