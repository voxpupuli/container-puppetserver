#!/bin/bash

set -e

ca_running() {
  status=$(curl --silent --fail --insecure "https://${CA_HOSTNAME}:${CA_PORT:-8140}/status/v1/simple")
  test "$status" = "running"
}

hocon() {
  /opt/puppetlabs/puppet/lib/ruby/vendor_gems/bin/hocon "$@"
}

if [[ "$CA_ENABLED" != "true" ]]; then
  # we are just an ordinary compiler
  echo "turning off CA"
  cat > /etc/puppetlabs/puppetserver/services.d/ca.cfg <<EOF
puppetlabs.services.ca.certificate-authority-disabled-service/certificate-authority-disabled-service
puppetlabs.trapperkeeper.services.watcher.filesystem-watch-service/filesystem-watch-service
EOF

  ssl_cert=$(puppet config print hostcert)
  ssl_key=$(puppet config print hostprivkey)
  ssl_ca_cert=$(puppet config print localcacert)
  ssl_crl_path=$(puppet config print hostcrl)


  cd /etc/puppetlabs/puppetserver/conf.d/
  hocon -f webserver.conf set webserver.ssl-cert $ssl_cert
  hocon -f webserver.conf set webserver.ssl-key $ssl_key
  hocon -f webserver.conf set webserver.ssl-ca-cert $ssl_ca_cert
  hocon -f webserver.conf set webserver.ssl-crl-path $ssl_crl_path
  cd /

  # bootstrap certs for the puppetserver
  if [[ ! -f "$ssl_cert" ]]; then
    while ! ca_running; do
      sleep 1
    done

    puppet ssl bootstrap --server="${CA_HOSTNAME}" --masterport="${CA_PORT:-8140}"
  fi
else
  # we are the CA
  hocon -f /etc/puppetlabs/puppetserver/conf.d/ca.conf \
    set certificate-authority.allow-subject-alt-names "${CA_ALLOW_SUBJECT_ALT_NAMES}"

  if [[ "$INTERMEDIATE_CA" == "true" ]]; then
    # sanity check
    if [[ -z $INTERMEDIATE_CA_BUNDLE ]]; then
      echo 'Error: When enabling intermediate ca, one MUST specify INTERMEDIATE_CA_BUNDLE'
      exit 99
    fi
    if [[ -z $INTERMEDIATE_CRL_CHAIN ]]; then
      echo 'Error: When enabling intermediate ca, one MUST specify INTERMEDIATE_CRL_CHAIN'
      exit 99
    fi
    if [[ -z $INTERMEDIATE_CA_KEY ]]; then
      echo 'Error: When enabling intermediate ca, one MUST specify INTERMEDIATE_CA_KEY'
      exit 99
    fi

    if [[ -f /etc/puppetlabs/puppetserver/ca/ca_crt.pem ]]; then
      echo "CA already imported."
    else
      puppetserver ca import \
        --cert-bundle $INTERMEDIATE_CA_BUNDLE \
        --crl-chain $INTERMEDIATE_CRL_CHAIN \
        --private-key $INTERMEDIATE_CA_KEY
    fi
  else
    new_cadir=/etc/puppetlabs/puppetserver/ca

    if [ ! -f "$new_cadir/ca_crt.pem" ] && [ ! -f "$SSLDIR/ca/ca_crt.pem" ]; then
        # There is no existing CA

        # Append user-supplied DNS Alt Names
        if [ -n "$DNS_ALT_NAMES" ]; then
            current="$(puppet config print --section main dns_alt_names)"
            # shell parameter expansion to remove trailing comma if there is one
            updated="${DNS_ALT_NAMES%,}"
            if [ -n "$current" ]; then updated="$current","$updated"; fi
            puppet config set --section main dns_alt_names "$updated"
        fi

        timestamp="$(date '+%Y-%m-%d %H:%M:%S %z')"
        ca_name="Puppet CA generated on ${HOSTNAME} at $timestamp"

        # See puppet.conf file for relevant settings
        puppetserver ca setup \
            --ca-name "$ca_name" \
            --config /etc/puppetlabs/puppet/puppet.conf

    elif [ ! -f "$new_cadir/ca_crt.pem" ] && [ -f "$SSLDIR/ca/ca_crt.pem" ]; then
        # Legacy CA upgrade
        puppetserver ca migrate \
            --config /etc/puppetlabs/puppet/puppet.conf
    fi
  fi
fi
