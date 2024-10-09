#!/bin/bash

pps_version=${1:-8.6.3}
pp_version=${2:-8.9.0}
container_version=${3:-1.0.1}

if [ -d puppetserver-${pps_version} ]; then
  rm -rf puppetserver-${pps_version}
fi

if [ -d puppet-${pp_version} ]; then
  rm -rf puppet-${pp_version}
fi

if [ ! -f puppetserver-${pps_version}.tar.gz ]; then
  curl -v https://downloads.puppet.com/puppet/puppetserver-${pps_version}.tar.gz -o puppetserver-${pps_version}.tar.gz
fi
if [ ! -f puppet-${pp_version}.tar.gz ]; then
  curl -v https://downloads.puppet.com/puppet/puppet-${pp_version}.tar.gz -o puppet-${pp_version}.tar.gz
fi

tar -xf puppetserver-${pps_version}.tar.gz
tar -xf puppet-${pp_version}.tar.gz

# cp Dockerfile puppetserver-${pps_version}/
# cd puppetserver-${pps_version}
docker build -t puppetserver:${pps_version}-v${container_version} .
