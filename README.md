# Voxpupuli Puppet Server container

[![CI](https://github.com/voxpupuli/container-puppetserver/actions/workflows/ci.yaml/badge.svg)](https://github.com/voxpupuli/container-puppetserver/actions/workflows/ci.yaml)
[![License](https://img.shields.io/github/license/voxpupuli/container-puppetserver.svg)](https://github.com/voxpupuli/container-puppetserver/blob/main/LICENSE)
[![Donated by Puppet](https://img.shields.io/badge/Donated%20by-Puppet-blue.svg)](https://www.puppet.com)
[![Sponsored by betadots GmbH](https://img.shields.io/badge/Sponsored%20by-betadots%20GmbH-blue.svg)](https://www.betadots.de)

---

- [Voxpupuli Puppet Server container](#voxpupuli-puppet-server-container)
  - [Note about environment caching](#note-about-environment-caching)
  - [New version schema](#new-version-schema)
  - [Configuration](#configuration)
  - [Initialization Scripts](#initialization-scripts)
  - [Persistance](#persistance)
  - [How to Release the container](#how-to-release-the-container)
  - [How to contribute](#how-to-contribute)
  - [Transfer Notice](#transfer-notice)

---

__⚠️ Attention ⚠️__: the container name `voxpupuli/container-puppetserver` will be deprecated in 2025-02 and might be removed in the future. Please use `voxpupuli/puppetserver` instead.

---

This project hosts the Dockerfile and the required scripts to build a Puppet Server container image.

You can run a copy of Puppet Server with the following Docker command:

```bash
docker run --name puppet --hostname puppet ghcr.io/voxpupuli/puppetserver:8.6.1-latest
```

Although it is not strictly necessary to name the container `puppet`, this is
useful when working with the other Puppet images, as they will look for a server
on that hostname by default.

If you would like to start the Puppet Server with your own Puppet code, you can
mount your own directory at `/etc/puppetlabs/code`:

```shell
 docker run --name puppet --hostname puppet -v ./code:/etc/puppetlabs/code ghcr.io/voxpupuli/puppetserver:8.6.1-latest
```

For compose file see: [CRAFTY](https://github.com/voxpupuli/crafty/tree/main/puppet/oss)

You can find out more about Puppet Server in the [official documentation](https://www.puppet.com/docs/puppet/7/server/about_server.html).

## Note about environment caching

⚠️ The Puppetserver has [the environment caching](https://www.puppet.com/docs/puppet/8/server/admin-api/v1/environment-cache.html) enabled by default.
You should explicitly call the API endpoint to clear the cache when a new environment is deployed.
See the `curl` example below.

```bash
curl -i --cert $(puppet config print hostcert) \
--key $(puppet config print hostprivkey) \
--cacert $(puppet config print cacert) \
-X DELETE \
https://$(puppet config print server):8140/puppet-admin-api/v1/environment-cache?environment=production
```

Another option is to disable the environment caching by setting the `PUPPETSERVER_ENVIRONMENT_TIMEOUT` environment variable to zero (`0`).

## New version schema

The new version schema has the following layout:

```text
<puppet.major>.<puppet.minor>.<puppet.patch>-v<container.major>.<container.minor>.<container.patch>
```

Example usage:

```shell
docker run --name puppet --hostname puppet -v ./code:/etc/puppetlabs/code/ ghcr.io/voxpupuli/puppetserver:8.6.1-v1.6.0
```

| Name | Description |
| --- | --- |
| puppet.major | Describes the contained major Puppet version (7 or 8) |
| puppet.minor | Describes the contained minor Puppet version |
| puppet.patch | Describes the contained patchlevel Puppet version |
| container.major | Describes the major version of the base container (Ubunutu 22.04) or incompatible changes |
| container.minor | Describes new features or refactoring with backward compatibility |
| container.patch | Describes if minor changes or bugfixes have been implemented |

## Configuration

The following environment variables are supported:

| Name                                       | Usage / Default                                                                                                                                               |
|--------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| __PUPPETSERVER_HOSTNAME__                  | The DNS name used on the servers SSL certificate - sets the `server` in puppet.conf<br><br>Defaults to unset.                                                 |
| __CERTNAME__                               | The DNS name used on the servers SSL certificate - sets the `certname` in puppet.conf<br><br>Defaults to unset.                                               |
| __DNS_ALT_NAMES__                          | Additional DNS names to add to the servers SSL certificate<br>__Note__ only effective on initial run when certificates are generated                          |
| __PUPPETSERVER_PORT__                      | The port of the puppetserver<br><br>`8140`                                                                                                                    |
| __AUTOSIGN__                               | Whether or not to enable autosigning on the puppetserver instance. Valid values are `true`, `false`, and `/path/to/autosign.conf`.<br><br>Defaults to `true`. |
| __CA_ENABLED__                             | Whether or not this puppetserver instance has a running CA (Certificate Authority)<br><br>`true`                                                              |
| __CA_HOSTNAME__                            | The DNS hostname for the puppetserver running the CA. Does nothing unless `CA_ENABLED=false`<br><br>`puppet`                                                  |
| __CA_PORT__                                | The listening port of the CA. Does nothing unless `CA_ENABLED=false`<br><br>`8140`                                                                            |
| __CA_ALLOW_SUBJECT_ALT_NAMES__             | Whether or not SSL certificates containing Subject Alternative Names should be signed by the CA. Does nothing unless `CA_ENABLED=true`.<br><br>`false`        |
| __INTERMEDIATE_CA__                        | Allows to import an existing intermediate CA. Needs `INTERMEDIATE_CA_BUNDLE`, `INTERMEDIATE_CA_CHAIN` and `INTERMEDIATE_CA_KEY`. See [Puppet Intermediat CA](https://www.puppet.com/docs/puppet/latest/server/intermediate_ca.html)                                                            |
| __INTERMEDIATE_CA_BUNDLE__                 | File path and name to the complete CA bundle (signing CA + Intermediate CA)                                                                                   |
| __INTERMEDIATE_CRL_CHAIN__                 | File path and name to the complete CA CRL chain                                                                                                               |
| __INTERMEDIATE_CA_KEY__                    | File path and name to the private CA key                                                                                                                      |
| __PUPPET_REPORTS__                         | Sets `reports` in puppet.conf<br><br>`puppetdb`                                                                                                               |
| __PUPPET_STORECONFIGS__                    | Sets `storeconfigs` in puppet.conf<br><br>`true`                                                                                                              |
| __PUPPET_STORECONFIGS_BACKEND__            | Sets `storeconfigs_backend` in puppet.conf<br><br>`puppetdb`                                                                                                  |
| __PUPPETSERVER_MAX_ACTIVE_INSTANCES__      | The maximum number of JRuby instances allowed<br><br>`1`                                                                                                      |
| __PUPPETSERVER_MAX_REQUESTS_PER_INSTANCE__ | The maximum HTTP requests a JRuby instance will handle in its lifetime (disable instance flushing)<br><br>`0`                                                 |
| __PUPPETSERVER_JAVA_ARGS__                 | Arguments passed directly to the JVM when starting the service<br><br>`-Xms1024m -Xmx1024m`                                                                   |
| __USE_PUPPETDB__                           | Whether to connect to puppetdb<br>Sets `PUPPET_REPORTS` to `log` and `PUPPET_STORECONFIGS` to `false` if those unset<br><br>`true`                            |
| __PUPPETDB_SERVER_URLS__                   | The `server_urls` to set in `/etc/puppetlabs/puppet/puppetdb.conf`<br><br>`https://puppetdb:8081`                                                             |
| __PUPPETDB_HOSTNAME__                      | The DNS name of the puppetdb <br><br> Defaults to `puppetdb`                                                                                                  |
| __PUPPETDB_SSL_PORT__                      | The TLS port of the puppetdb <br><br> Defaults to `8081`                                                                                                      |
| __PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED__ | Activate the graphite exporter. Also needs __PUPPETSERVER_GRAPHITE_HOST__ and __PUPPETSERVER_GRAPHITE_PORT__<br><br>  Defaults to `false`                     |
| __PUPPETSERVER_GRAPHITE_HOST__             | Only used if __PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED__ is set to `true`. FQDN or Hostname of the graphite server where puppet should push metrics to. <br><br> Defaults to `exporter` |
| __PUPPETSERVER_GRAPHITE_PORT__             | Only used if __PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED__ is set to `true`. Port of the graphite server where puppet should push metrics to. <br><br> Default to `9109` |
| __PUPPETSERVER_ENVIRONMENT_TIMEOUT__       | Configure the environment timeout<br><br> Defaults to `unlimited`                                                                                             |
| __PUPPETSERVER_ENABLE_ENV_CACHE_DEL_API__  | Enable the puppet admin api endpoint via certificates to allow clearing environment caches<br><br> Defaults to `true`                                         |
| __ENVIRONMENTPATH__                        | Set an environmentpath<br><br> Defaults to `/etc/puppetlabs/code/environments`                                                                                |
| __HIERACONFIG__                            | Set a hiera_config entry in puppet.conf file<br><br> Defaults to `$confdir/hiera.yaml`                                                                        |
| __CSR_ATTRIBUTES__                         | Provide a JSON string of the csr_attributes.yaml content. e.g. `CSR_ATTRIBUTES='{"custom_attributes": { "challengePassword": "foobar" }, "extension_requests": { "pp_project": "foo" } }'`<br><br> Please note that within a compose file, you must provide all environment variables as Hash and not as Array!<br> environment:<br> `CSR_ATTRIBUTES: '{"extension_request": {...}}'` |

## Initialization Scripts

If you would like to do additional initialization, add a directory called `/docker-custom-entrypoint.d/` and fill it with `.sh` scripts.

You can also create sub-directories in `/docker-custom-entrypoint.d/` for scripts that have to run at different stages.

- `/docker-custom-entrypoint.d/pre-default/` - scripts that run before the default entrypoint scripts from this repo run.
- `/docker-custom-entrypoint.d/` - scripts that run after the default entrypoint scripts, but before the puppetserver service is started.
- `/docker-custom-entrypoint.d/post-startup/` - scripts that run after the puppetserver service is started.
- `/docker-custom-entrypoint.d/sigterm-handler/` - scripts that run when the container receives a SIGTERM signal.
- `/docker-custom-entrypoint.d/post-execution/` - scripts that run after the puppetserver service has stopped.

## Persistance

If you plan to use the in-server CA, restarting the container can cause the server's keys and certificates to change, causing agents and the server to stop trusting each other.
To prevent this, you can persist the default cadir, `/etc/puppetlabs/puppetserver/ca`.
For example:

```shell
docker run -v $PWD/ca-ssl:/etc/puppetlabs/puppetserver/ca ghcr.io/voxpupuli/puppetserver:8.6.1-latest
```

or in compose:

```yaml
services:
  puppet:
    image: ghcr.io/voxpupuli/puppetserver:8.6.1-latest
    # ...
    volumes:
      - ./ca-ssl:/etc/puppetlabs/puppetserver/ca
```

## How to Release the container

[see here](https://github.com/voxpupuli/crafty/blob/main/RELEASE.md)

## How to contribute

[see here](https://github.com/voxpupuli/crafty/blob/main/CONTRIBUTING.md)

## Transfer Notice

This project was originally authored by [Puppet](https://github.com/puppetlabs).
The maintainer preferred that Vox Pupuli take ownership of the project for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here.
