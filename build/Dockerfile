FROM openjdk:24-bullseye

ENV opt_dir=/opt/puppetlabs/server/apps/puppetserver
ENV etc_dir=/etc/puppetlabs/puppetserver

WORKDIR $opt_dir

COPY puppet-server-release.jar $opt_dir/puppet-server-release.jar

COPY ext/cli $opt_dir/cli/apps
COPY ext/cli_defaults/cli-defaults.sh $opt_dir/cli/cli-defaults.sh
COPY ext/bin $opt_dir/bin
COPY ext/bin/puppetserver /opt/puppetlabs/bin/puppetserver
COPY ext/ezbake-functions.sh $opt_dir/ezbake-functions.sh
COPY install.sh $opt_dir/scripts/install.sh

COPY ext/ezbake.manifest $opt_dir/ezbake.manifest
COPY ext/system-config/services.d/bootstrap.cfg $opt_dir/config/services.d/bootstrap.cfg
COPY ext/config/conf.d $etc_dir/conf.d
COPY ext/config/services.d $etc_dir/services.d
COPY ext/default /etc/default/puppetserver

COPY ext/config/logback.xml \
     ext/config/request-logging.xml \
     ${etc_dir}

RUN useradd --uid 1001 --home-dir ${opt_dir} --shell /usr/sbin/nologin --user-group puppet \
&& chown -R puppet:puppet /opt/puppetlabs \
&& chown -R puppet:puppet /etc/puppetlabs \
&& chmod +x /opt/puppetlabs/bin/* \
&& chmod +x ${opt_dir}/bin/* \
&& chmod +x ${opt_dir}/cli/**/* \
&& chmod +x ${opt_dir}/scripts/* \
&& chmod +x ${opt_dir}/ezbake-functions.sh \
&& ln -s /usr/local/openjdk-24/bin/java /usr/bin/java

EXPOSE 8140

ENTRYPOINT ["/opt/puppetlabs/bin/puppetserver"]
CMD ["start"]
