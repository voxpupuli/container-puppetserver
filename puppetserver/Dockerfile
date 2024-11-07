FROM ubuntu:22.04

ARG vcs_ref
ARG build_type
ARG build_date
ARG PACKAGES="ca-certificates git netbase openjdk-17-jre-headless ruby3.0 openssh-client libssh2-1 dumb-init"
ARG BUILD_PKGS="ruby3.0-dev gcc make cmake pkg-config libssl-dev libc6-dev libssh2-1-dev"
ARG TARGETARCH
ARG R10K_VERSION=4.1.0
ARG RUGGED_VERSION=1.7.2
ARG PUPPET_RELEASE=8
ARG PUPPETSERVER_VERSION=8.6.1
ARG UBUNTU_CODENAME=jammy
ARG PUPPET_USER_UID=999
ARG PUPPET_USER_GID=999

LABEL org.label-schema.maintainer="Voxpupuli Team <voxpupuli@groups.io>" \
      org.label-schema.vendor="Voxpupuli" \
      org.label-schema.url="https://github.com/voxpupuli/container-puppetserver" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.vcs-url="https://github.com/voxpupuli/container-puppetserver" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile" \
      org.label-schema.name="Puppet Server ($build_type)" \
      org.label-schema.version="$PUPPETSERVER_VERSION" \
      org.label-schema.vcs-ref="$vcs_ref" \
      org.label-schema.build-date="$build_date"

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
    INTERMEDIATE_CA=false \
    INTERMEDIATE_CA_BUNDLE=/etc/puppetlabs/intermediate/ca.pem \
    INTERMEDIATE_CRL_CHAIN=/etc/puppetlabs/intermediate/crl.pem \
    INTERMEDIATE_CA_KEY=/etc/puppetlabs/intermediate/key.pem \
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
    CSR_ATTRIBUTES='{}' \
    PUPPET_DEB=puppet${PUPPET_RELEASE}-release-${UBUNTU_CODENAME}.deb

COPY docker-entrypoint.sh \
     healthcheck.sh \
     /
COPY docker-entrypoint.d /docker-entrypoint.d
COPY metrics.conf.tmpl /metrics.conf.tmpl
COPY add_cache_del_api_auth_rules.rb /add_cache_del_api_auth_rules.rb
COPY Dockerfile /

ADD https://apt.puppet.com/${PUPPET_DEB} /${PUPPET_DEB}

# Create puppet user and group with PUPPET_USER_UID and PUPPET_USER_GID
RUN groupadd -g ${PUPPET_USER_GID} puppet && \
    useradd -m -u ${PUPPET_USER_UID} -g puppet puppet

# no need to pin versions or clear apt cache as its still being used
# hadolint ignore=DL3008,DL3009
RUN dpkg -i /${PUPPET_DEB} && \
    rm /${PUPPET_DEB} && \
    chmod +x /docker-entrypoint.sh /healthcheck.sh /docker-entrypoint.d/*.sh && \
    apt-get update && \
    apt-get install -y --no-install-recommends $PACKAGES $BUILD_PKGS && \
    gem install --no-doc r10k -v $R10K_VERSION && \
    gem install --no-doc rugged -v $RUGGED_VERSION -- --with-ssh && \
    apt remove -y $BUILD_PKGS && \
    apt-get install --no-install-recommends -y puppetserver=${PUPPETSERVER_VERSION}-1${UBUNTU_CODENAME} puppetdb-termini && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
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

# k8s uses livenessProbe, startupProbe, readinessProbe and ignores HEALTHCHECK
HEALTHCHECK --interval=20s --timeout=15s --retries=12 --start-period=3m CMD ["/healthcheck.sh"]

# NOTE: this is just documentation on defaults
EXPOSE 8140

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["foreground"]
