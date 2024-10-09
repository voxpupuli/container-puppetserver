FROM openjdk:24-bullseye

ADD puppetserver-8.6.3 /install

ENV apps_dir=/opt/puppetlabs/server/apps
ENV app_logdir=/var/log/puppetlabs/puppetserver
ENV data_dir=/opt/puppetlabs/server/data
ENV etc_dir=/etc/puppetlabs
ENV rundir=/var/run/puppetlabs/puppetserver
ENV bindir=/opt/puppetlabs/server/apps/puppetserver/bin
ENV symbindir=/opt/puppetlabs/server/bin
ENV uxbindir=/opt/puppetlabs/bin

RUN cd /install \
&& install -d -m 0755 "${apps_dir}/puppetserver" \
&& install -d -m 0770 "${data_dir}/puppetserver" \
&& install -m 0644 puppet-server-release.jar "${apps_dir}/puppetserver" \
&& install -m 0774 ext/ezbake-functions.sh "${apps_dir}/puppetserver" \
&& install -m 0644 ext/ezbake.manifest "${apps_dir}/puppetserver" \
&& install -d -m 0755 "${etc_dir}/puppetserver/conf.d" \
&& install -d -m 0755 "${etc_dir}/puppetserver/services.d" \
&& install -m 0644 ext/config/request-logging.xml "${etc_dir}/puppetserver/request-logging.xml" \
&& install -m 0644 ext/config/conf.d/puppetserver.conf "${etc_dir}/puppetserver/conf.d/puppetserver.conf" \
&& install -m 0644 ext/config/logback.xml "${etc_dir}/puppetserver/logback.xml" \
&& install -m 0644 ext/config/services.d/ca.cfg "${etc_dir}/puppetserver/services.d/ca.cfg" \
&& install -m 0644 ext/config/conf.d/global.conf "${etc_dir}/puppetserver/conf.d/global.conf" \
&& install -m 0644 ext/config/conf.d/web-routes.conf "${etc_dir}/puppetserver/conf.d/web-routes.conf" \
&& install -m 0644 ext/config/conf.d/auth.conf "${etc_dir}/puppetserver/conf.d/auth.conf" \
&& install -m 0644 ext/config/conf.d/metrics.conf "${etc_dir}/puppetserver/conf.d/metrics.conf" \
&& install -m 0644 ext/config/conf.d/ca.conf "${etc_dir}/puppetserver/conf.d/ca.conf" \
&& install -m 0644 ext/config/conf.d/webserver.conf "${etc_dir}/puppetserver/conf.d/webserver.conf" \
&& install -d -m 0755 "${apps_dir}/puppetserver/cli" \
&& install -d -m 0755 "${apps_dir}/puppetserver/cli/apps" \
&& install -d -m 0755 "${bindir}" \
&& install -d -m 0755 "${symbindir}" \
&& install -d -m 0755 "${uxbindir}" \
&& install -m 0755 "ext/bin/puppetserver" "${bindir}/puppetserver" \
&& ln -s "../apps/puppetserver/bin/puppetserver" "${symbindir}/puppetserver" \
&& ln -s "../server/apps/puppetserver/bin/puppetserver" "${uxbindir}/puppetserver" \
&& install -m 0755 ext/cli/foreground "${apps_dir}/puppetserver/cli/apps/foreground" \
&& install -m 0755 ext/cli/dropsonde "${apps_dir}/puppetserver/cli/apps/dropsonde" \
&& install -m 0755 ext/cli/ca "${apps_dir}/puppetserver/cli/apps/ca" \
&& install -m 0755 ext/cli/irb "${apps_dir}/puppetserver/cli/apps/irb" \
&& install -m 0755 ext/cli/gem "${apps_dir}/puppetserver/cli/apps/gem" \
&& install -m 0755 ext/cli/reload "${apps_dir}/puppetserver/cli/apps/reload" \
&& install -m 0755 ext/cli/ruby "${apps_dir}/puppetserver/cli/apps/ruby" \
&& install -m 0755 ext/cli/stop "${apps_dir}/puppetserver/cli/apps/stop" \
&& install -m 0755 ext/cli/start "${apps_dir}/puppetserver/cli/apps/start" \
&& install -m 0644 puppet-server-release.jar "${apps_dir}/puppetserver" \
&& install -d -m 0700 "${app_logdir}" \
&& install -d -m 0755 "${rundir}" \
&& install -d -m 700 "${data_dir}/puppetserver/jars" \
&& install -d -m 700 "${data_dir}/puppetserver/yaml"

RUN echo 'alias ll="ls -la --color=auto"' >> ~/.bashrc

RUN useradd --uid 1001 --home-dir ${data_dir}/puppetserver --shell /usr/sbin/nologin --user-group puppet \
&& install --owner=puppet --group=puppet -d /opt/puppetlabs/server/data/puppetserver/jruby-gems \
&& install --directory --owner=puppet --group=puppet --mode=775 /opt/puppetlabs/server/data \
&& install --directory "${etc_dir}/puppet/ssl" \
&& install --directory "${etc_dir}/puppetserver/ca" \
&& chown -R puppet:puppet ${etc_dir}/puppet/ssl \
&& chown -R puppet:puppet ${etc_dir}/puppetserver/ca \
&& find /etc/puppetlabs/puppet/ssl -type d -print0 | xargs -0 chmod 770 \
&& ln -s /usr/local/openjdk-24/bin/java /usr/bin/java
# && /opt/puppetlabs/bin/puppetserver gem install puppet

EXPOSE 8140

# ENTRYPOINT ["/opt/puppetlabs/bin/puppetserver"]
# CMD ["start"]
