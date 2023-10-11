ARG build_type=release
ARG UBUNTU_CODENAME=jammy

######################################################
# base
######################################################

FROM ubuntu:22.04 as base

ARG PACKAGES=ca-certificates\ git
ARG DUMB_INIT_VERSION="1.2.5"

LABEL org.label-schema.maintainer="<voxpupuli@groups.io>" \
      org.label-schema.vendor="Vox Pupuli" \
      org.label-schema.url="https://github.com/voxpupuli/puppetserver-docker" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.vcs-url="https://github.com/voxpupuli/puppetserver-docker" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

# ENV PUPPERWARE_ANALYTICS_TRACKING_ID="UA-132486246-4" \
#     PUPPERWARE_ANALYTICS_APP_NAME="puppetserver" \
ENV PUPPERWARE_ANALYTICS_ENABLED=false \
    PUPPETSERVER_JAVA_ARGS="-Xms1024m -Xmx1024m" \
    PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH \
    SSLDIR=/etc/puppetlabs/puppet/ssl \
    LOGDIR=/var/log/puppetlabs/puppetserver \
    PUPPETSERVER_HOSTNAME="" \
    DNS_ALT_NAMES="" \
    PUPPET_MASTERPORT=8140 \
    AUTOSIGN="" \
    PUPPETSERVER_MAX_ACTIVE_INSTANCES=1 \
    PUPPETSERVER_MAX_REQUESTS_PER_INSTANCE=0 \
    CA_ENABLED=true \
    CA_HOSTNAME=puppet \
    CA_MASTERPORT=8140 \
    CA_ALLOW_SUBJECT_ALT_NAMES=false \
    USE_PUPPETDB=true \
    PUPPETDB_SERVER_URLS=https://puppetdb:8081 \
    PUPPET_STORECONFIGS_BACKEND="puppetdb" \
    PUPPET_STORECONFIGS=true \
    PUPPET_REPORTS="puppetdb"

# NOTE: this is just documentation on defaults
EXPOSE 8140

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["foreground"]

ADD https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_amd64.deb /

COPY docker-entrypoint.sh \
     healthcheck.sh \
     /
COPY docker-entrypoint.d /docker-entrypoint.d
# k8s uses livenessProbe, startupProbe, readinessProbe and ignores HEALTHCHECK
HEALTHCHECK --interval=20s --timeout=15s --retries=12 --start-period=3m CMD ["/healthcheck.sh"]

# no need to pin versions or clear apt cache as its still being used
# hadolint ignore=DL3008,DL3009
RUN chmod +x /docker-entrypoint.sh /healthcheck.sh /docker-entrypoint.d/*.sh && \
    apt-get update && \
    apt-get install -y --no-install-recommends $PACKAGES && \
    dpkg -i dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    rm dumb-init_"$DUMB_INIT_VERSION"_amd64.deb

FROM base as edge

ARG UBUNTU_CODENAME
ARG deb_uri=http://nightlies.puppet.com/apt/puppet7-nightly-release-$UBUNTU_CODENAME.deb

######################################################
# release (build from packages)
######################################################

FROM base as release

ARG version
ARG UBUNTU_CODENAME
ARG install_path=puppetserver="$version"-1"$UBUNTU_CODENAME"
ARG deb_uri=https://apt.puppetlabs.com/puppet7-release-$UBUNTU_CODENAME.deb

######################################################
# final image
######################################################

# dynamically selects "edge" or "release" alias based on ARG
# hadolint ignore=DL3006
FROM ${build_type} as final

ARG build_type
ARG vcs_ref
ARG version
ARG build_date
ARG install_path
ARG deb_uri
# used by entrypoint to submit metrics to Google Analytics;
# published images should use "production" for this build_arg
# ARG pupperware_analytics_stream="dev"

# hadolint ignore=DL3020
ADD $deb_uri /puppet.deb

# hadolint ignore=DL3008,DL3028
RUN dpkg -i /puppet.deb && \
    rm /puppet.deb
RUN apt-get update && \
    apt-get install --no-install-recommends -y $install_path puppetdb-termini && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    gem install --no-doc r10k && \
    puppet config set autosign true --section master && \
    cp -pr /etc/puppetlabs/puppet /var/tmp && \
    cp -pr /opt/puppetlabs/server/data/puppetserver /var/tmp && \
    rm -rf /var/tmp/puppet/ssl

COPY puppetserver /etc/default/puppetserver
COPY logback.xml \
     request-logging.xml \
     /etc/puppetlabs/puppetserver/
COPY puppetserver.conf /etc/puppetlabs/puppetserver/conf.d/
COPY puppetdb.conf /var/tmp/puppet/

# dynamic LABELs and ENV vars placed lower for the sake of Docker layer caching
# these are specific to analytics
# ENV PUPPERWARE_ANALYTICS_STREAM="$pupperware_analytics_stream" \
#     PUPPET_SERVER_VERSION="$version"

LABEL org.label-schema.name="Puppet Server ($build_type)" \
      org.label-schema.version="$version" \
      org.label-schema.vcs-ref="$vcs_ref" \
      org.label-schema.build-date="$build_date"

COPY Dockerfile /
