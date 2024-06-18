ARG build_type=release
ARG UBUNTU_CODENAME=jammy

######################################################
# base
######################################################

FROM ubuntu:22.04 as base

ARG PACKAGES=ca-certificates\ git\ netbase\ openjdk-17-jre-headless\ ruby3.0
ARG DUMB_INIT_VERSION="1.2.5"
ARG TARGETARCH

LABEL org.label-schema.maintainer="Voxpupuli Team <info@voxpupuli.org>" \
      org.label-schema.vendor="Voxpupuli" \
      org.label-schema.url="https://github.com/voxpupuli/container-puppetserver" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.vcs-url="https://github.com/voxpupuli/container-puppetserver" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

ENV PUPPETSERVER_JAVA_ARGS="-Xms1024m -Xmx1024m" \
    PATH=$PATH:/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin \
    SSLDIR=/etc/puppetlabs/puppet/ssl \
    LOGDIR=/var/log/puppetlabs/puppetserver \
    PUPPETSERVER_HOSTNAME="" \
    CERTNAME="" \
    DNS_ALT_NAMES="" \
    PUPPETSERVER_PORT=8140 \
    AUTOSIGN=true \
    PUPPETSERVER_MAX_ACTIVE_INSTANCES=1 \
    PUPPETSERVER_MAX_REQUESTS_PER_INSTANCE=0 \
    CA_ENABLED=true \
    CA_HOSTNAME=puppet \
    CA_PORT=8140 \
    CA_ALLOW_SUBJECT_ALT_NAMES=false \
    USE_PUPPETDB=true \
    PUPPETDB_SERVER_URLS=https://puppetdb:8081 \
    PUPPET_STORECONFIGS_BACKEND="puppetdb" \
    PUPPET_STORECONFIGS=true \
    PUPPET_REPORTS="puppetdb" \
    PUPPETSERVER_GRAPHITE_EXPORTER_ENABLED=false \
    PUPPETSERVER_GRAPHITE_PORT=9109 \
    PUPPETSERVER_GRAPHITE_HOST=exporter \
    PUPPETSERVER_ENVIRONMENT_TIMEOUT=unlimited \
    PUPPETSERVER_ENABLE_ENV_CACHE_DEL_API=true \
    ENVIRONMENTPATH=/etc/puppetlabs/code/environments \
    HIERACONFIG='$confdir/hiera.yaml' \
    CSR_ATTRIBUTES='{}'

# NOTE: this is just documentation on defaults
EXPOSE 8140

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["foreground"]

ADD https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_"$TARGETARCH".deb /

COPY docker-entrypoint.sh \
     healthcheck.sh \
     /
COPY docker-entrypoint.d /docker-entrypoint.d
COPY metrics.conf.tmpl /metrics.conf.tmpl
COPY add_cache_del_api_auth_rules.rb /add_cache_del_api_auth_rules.rb
# k8s uses livenessProbe, startupProbe, readinessProbe and ignores HEALTHCHECK
HEALTHCHECK --interval=20s --timeout=15s --retries=12 --start-period=3m CMD ["/healthcheck.sh"]

# no need to pin versions or clear apt cache as its still being used
# hadolint ignore=DL3008,DL3009
RUN chmod +x /docker-entrypoint.sh /healthcheck.sh /docker-entrypoint.d/*.sh && \
    apt-get update && \
    apt-get install -y --no-install-recommends $PACKAGES && \
    dpkg -i dumb-init_"$DUMB_INIT_VERSION"_"$TARGETARCH".deb && \
    rm dumb-init_"$DUMB_INIT_VERSION"_"$TARGETARCH".deb

######################################################
# release (build from packages)
######################################################

FROM base as release

ARG PUPPET_RELEASE
ENV PUPPET_RELEASE=${PUPPET_RELEASE:-7}

ARG PUPPETSERVER_VERSION
ENV PUPPETSERVER_VERSION=${PUPPETSERVER_VERSION:-7.13.0}

ARG UBUNTU_CODENAME

######################################################
# final image
######################################################

# dynamically selects "edge" or "release" alias based on ARG
# hadolint ignore=DL3006
FROM ${build_type} as final

ARG vcs_ref
ARG build_type
ARG build_date

ENV PUPPET_DEB=puppet${PUPPET_RELEASE}-release-${UBUNTU_CODENAME}.deb
ADD https://apt.puppet.com/${PUPPET_DEB} /${PUPPET_DEB}

# hadolint ignore=DL3008,DL3028
RUN dpkg -i /${PUPPET_DEB} && \
    rm /${PUPPET_DEB}
RUN apt-get update && \
    apt-get install --no-install-recommends -y puppetserver=${PUPPETSERVER_VERSION}-1${UBUNTU_CODENAME} puppetdb-termini && \
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

COPY conf.d/puppetserver.conf /etc/puppetlabs/puppetserver/conf.d/
COPY conf.d/product.conf /etc/puppetlabs/puppetserver/conf.d/

COPY puppetdb.conf /var/tmp/puppet/

COPY enc/* /etc/puppetlabs/puppet
COPY reports/* /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/reports
RUN chmod +x /etc/puppetlabs/puppet/*.rb && \
    chmod +x /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/reports/*.rb

LABEL org.label-schema.name="Puppet Server ($build_type)" \
      org.label-schema.version="$PUPPETSERVER_VERSION" \
      org.label-schema.vcs-ref="$vcs_ref" \
      org.label-schema.build-date="$build_date"

COPY Dockerfile /
