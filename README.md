# Voxpupuli Puppet Server container

[![Sponsored by betadots GmbH](https://img.shields.io/badge/Sponsored%20by-betadots%20GmbH-blue.svg)](https://www.betadots.de)
[![License](https://img.shields.io/github/license/voxpupuli/container-puppetserver.svg)](https://github.com/voxpupuli/container-puppetserver/blob/main/LICENSE)

This project hosts the Dockerfile and the required scripts to build a Puppet Server container image.

For compose file see: [CRAFTY](https://github.com/voxpupuli/crafty)

## How to build the container

If you wanna build for example puppetserver 7.13.0, you can do it like this:
Check the latest deb package version [here](https://apt.puppet.com/pool/jammy/puppet7/p/puppetserver/index.html). The container is Ubuntu 22.04 at the moment.

If you checked the version and it is available as Ubuntu package, just create a tag and push it.

```bash
git tag 7.13.0
git push --tags
```

The build will be triggerd on any new tag. The tag has to match the version, because it is used internally as version referrence.

The build system watches for tags which begin with a 7 for puppet7-release and 8 for puppet8-release.
