#! /bin/sh

set -e

### Print configuration for troubleshooting
echo "System configuration values:"
# shellcheck disable=SC2039 # Docker injects $HOSTNAME
echo "* HOSTNAME: '${HOSTNAME}'"
echo "* hostname -f: '$(hostname -f)'"

if [ -n "${CERTNAME}" ]; then
  echo "* CERTNAME: '${CERTNAME}'"
  certname=${CERTNAME}.pem
else
  echo "* CERTNAME: unset, try to use the oldest certificate in the certs directory, because this might be the one that was used initially."
  certname=$(cd "${SSLDIR}/certs" && find * -type f -name '*.pem' ! -name ca.pem -print0 | xargs -0 ls -1tr | head -n 1)
  if [ -z "${certname}" ]; then
    echo "WARNING: No certificates found in ${SSLDIR}/certs! Please set CERTNAME!"
  fi
fi

echo "* PUPPETSERVER_PORT: '${PUPPETSERVER_PORT:-8140}'"
echo "* Certname: '${certname}'"
echo "* DNS_ALT_NAMES: '${DNS_ALT_NAMES}'"
echo "* SSLDIR: '${SSLDIR}'"

altnames="-certopt no_subject,no_header,no_version,no_serial,no_signame,no_validity,no_issuer,no_pubkey,no_sigdump,no_aux"

if [ -f "${SSLDIR}/certs/ca.pem" ]; then
  echo "CA Certificate:"
  # shellcheck disable=SC2086 # $altnames shouldn't be quoted
  openssl x509 -subject -issuer -text -noout -in "${SSLDIR}/certs/ca.pem" $altnames
fi

if [ -n "${certname}" ]; then
  echo "Certificate ${certname}:"
  # shellcheck disable=SC2086 # $altnames shouldn't be quoted
  openssl x509 -subject -issuer -text -noout -in "${SSLDIR}/certs/${certname}" $altnames
fi
