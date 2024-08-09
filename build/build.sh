#!/bin/bash

software_version=${1:-8.6.2}
container_version=${2:-1.0.0}

curl -v https://downloads.puppet.com/puppet/puppetserver-${software_version}.tar.gz -o puppetserver-${software_version}.tar.gz
tar -xvf puppetserver-${software_version}.tar.gz

cp Dockerfile puppetserver-${software_version}/
cd puppetserver-${software_version}
docker build -t puppetserver:${software_version}-v${container_version} .

cd -
rm -rf puppetserver-${software_version}
rm puppetserver-${software_version}.tar.gz
