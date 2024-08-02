# Voxpupuli Puppet Server container

[![CI](https://github.com/voxpupuli/container-puppetserver/actions/workflows/ci.yaml/badge.svg)](https://github.com/voxpupuli/container-puppetserver/actions/workflows/ci.yaml)
[![License](https://img.shields.io/github/license/voxpupuli/container-puppetserver.svg)](https://github.com/voxpupuli/container-puppetserver/blob/main/LICENSE)
[![Donated by Puppet](https://img.shields.io/badge/Donated%20by-Puppet-blue.svg)](https://www.puppet.com)
[![Sponsored by betadots GmbH](https://img.shields.io/badge/Sponsored%20by-betadots%20GmbH-blue.svg)](https://www.betadots.de)

---

- [Voxpupuli Puppet Server container](#voxpupuli-puppet-server-container)
  - [New version schema](#new-version-schema)
  - [Configuration](#configuration)
  - [Initialization Scripts](#initialization-scripts)
  - [Persistance](#persistance)
  - [How to Release the container](#how-to-release-the-container)
  - [How to contribute](#how-to-contribute)
  - [Transfer notice](#transfer-notice)

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
| **PUPPETSERVER_HOSTNAME**                  | The DNS name used on the servers SSL certificate - sets the `server` in puppet.conf<br><br>Defaults to unset.                                                 |
| **CERTNAME**                               | The DNS name used on the servers SSL certificate - sets the `certname` in puppet.conf<br><br>Defaults to unset.                                               |
| **DNS_ALT_NAMES**                          | Additional DNS names to add to the servers SSL certificate<br>**Note** only effective on initial run when certificates are generated                          |
| **PUPPETSERVER_PORT**                      | The port of the puppetserver<br><br>`8140`                                                                                                                    |
| **AUTOSIGN**                               | Whether or not to enable autosigning on the puppetserver instance. Valid values are `true`, `false`, and `/path/to/autosign.conf`.<br><br>Defaults to `true`. |
| **CA_ENABLED**                             | Whether or not this puppetserver instance has a running CA (Certificate Authority)<br><br>`true`                                                              |
| **CA_HOSTNAME**                            | The DNS hostname for the puppetserver running the CA. Does nothing unless `CA_ENABLED=false`<br><br>`puppet`                                                  |
| **CA_PORT**                                | The listening port of the CA. Does nothing unless `CA_ENABLED=false`<br><br>`8140`                                                                            |
| **CA_ALLOW_SUBJECT_ALT_NAMES**             | Whether or not SSL certificates containing Subject Alternative Names should be signed by the CA. Does nothing unless `CA_ENABLED=true`.<br><br>`false`        |
| **PUPPET_REPORTS**                         | Sets `reports` in puppet.conf<br><br>`puppetdb`                                                                                                               |
| **PUPPET_STORECONFIGS**                    | Sets `storeconfigs` in puppet.conf<br><br>`true`                                                                                                              |
| **PUPPET_STORECONFIGS_BACKEND**            | Sets `storeconfigs_backend` in puppet.conf<br><br>`puppetdb`                                                                                                  |
| **PUPPETSERVER_MAX_ACTIVE_INSTANCES**      | The maximum number of JRuby instances allowed<br><br>`1`                                                                                                      |
| **PUPPETSERVER_MAX_REQUESTS_PER_INSTANCE** | The maximum HTTP requests a JRuby instance will handle in its lifetime (disable instance flushing)<br><br>`0`                                                 |
| **PUPPETSERVER_JAVA_ARGS**                 | Arguments passed directly to the JVM when starting the service<br><br>`-Xms512m -Xmx512m`                                                                     |
| **USE_PUPPETDB**                           | Whether to connect to puppetdb<br>Sets `PUPPET_REPORTS` to `log` and `PUPPET_STORECONFIGS` to `false` if those unset<br><br>`true`                            |
| **PUPPETDB_SERVER_URLS**                   | The `server_urls` to set in `/etc/puppetlabs/puppet/puppetdb.conf`<br><br>`https://puppetdb:8081`                                                             |
| **PUPPETDB_HOSTNAME**                      | The DNS name of the puppetdb <br><br> Defaults to `puppetdb`                                                                                                  |
| **PUPPETDB_SSL_PORT**                      | The TLS port of the puppetdb <br><br> Defaults to `8081`                                                                                                      |
| **PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED** | Activate the graphite exporter. Also needs **PUPPETSERVER_GRAPHITE_HOST** and **PUPPETSERVER_GRAPHITE_PORT**<br><br>  Defaults to `false`                     |
| **PUPPETSERVER_GRAPHITE_HOST**             | Only used if **PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED** is set to `true`. FQDN or Hostname of the graphite server where puppet should push metrics to. <br><br> Defaults to `exporter` |
| **PUPPETSERVER_GRAPHITE_PORT**             | Only used if **PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED** is set to `true`. Port of the graphite server where puppet should push metrics to. <br><br> Default to `9109` |
| **PUPPETSERVER_ENVIRONMENT_TIMEOUT**       | Configure the environment timeout<br><br> Defaults to `unlimited`                                                                                             |
| **PUPPETSERVER_ENABLE_ENV_CACHE_DEL_API**  | Enable the puppet admin api endpoint via certificates to allow clearing environment caches<br><br> Defaults to `true`                                         |
| **ENVIRONMENTPATH**                        | Set an environmentpath<br><br> Defaults to `/etc/puppetlabs/code/environments`                                                                                |
| **HIERACONFIG**                            | Set a hiera_config entry in puppet.conf file<br><br> Defaults to `$confdir/hiera.yaml`                                                                        |
| **CSR_ATTRIBUTES**                         | Provide a JSON string of the csr_attributes.yaml content. e.g. `CSR_ATTRIBUTES='{"custom_attributes": { "challengePassword": "foobar" }, "extension_requests": { "pp_project": "foo" } }'`<br><br> Defaults to empty JSON object `{}`<br> Please note that within a compose file, you must provide all environment variables as Hash and not as Array!<br> environment:<br> `CSR_ATTRIBUTES: '{"extension_request": {...}}'` |

## Initialization Scripts

If you would like to do additional initialization, add a directory called `/docker-custom-entrypoint.d/` and fill it with `.sh` scripts.
These scripts will be executed at the end of the entrypoint script, before the service is ran.

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
