#!/bin/bash

if test -n "${ADDITIONAL_CERTIFICATES}" ; then
  # split string into array
  IFS=',' read -ra certnames <<< "$ADDITIONAL_CERTIFICATES"

  for i in "${certnames[@]}"; do
    echo "Generating: $i"
    # use force to gen cert while puppetserver is still offline
    # puppetserver will always fail, because it tries to connect to the API
    # so we add || true to ignore the error
    # if the cert already exists, it will not be overwritten
    # puppetserver acknowledges the cert and continue
    puppetserver ca generate --certname $i --force || true
  done
fi
