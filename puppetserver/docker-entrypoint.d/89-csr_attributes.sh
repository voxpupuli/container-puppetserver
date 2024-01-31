#!/bin/bash
echo $CSR_ATTRIBUTES
/opt/puppetlabs/puppet/bin/ruby /docker-entrypoint.d/89-csr_attributes.rb
