#!/bin/bash
# bash is required to pass ENV vars with dots as sh cannot

set -o errexit  # exit on any command failure; use `whatever || true` to accept failures
                # use `if something; then` instead of `something; if [ $? -eq 0 ]; then`
                # use `rv=0; something || rv=$?` if you really need the exact exit code
set -o pipefail # pipes fail when any command fails, not just the last one. Use: ( whatever || true ) | somethingelse
set -o nounset  # exit on use of undeclared var, use `${possibly_undefined-}` to substitute the empty string in that case
                # You can assign default values like this:
                # `: ${possibly_undefined=default}`
                # `: ${possibly_undefined_or_empty:=default}` will also replace an empty (but declared) value
# set -o xtrace

pid=0

echoerr() { echo "$@" 1>&2; }

echoerr "Entrypoint PID $$"

## Pre execution handler
pre_execution_handler() {
  if [ -d /docker-custom-entrypoint.d/ ]; then
    if [ -d /docker-custom-entrypoint.d/pre-default/ ]; then
      find /docker-custom-entrypoint.d/pre-default/ -type f -name "*.sh" \
        -exec chmod +x {} \;
      sync
      for f in /docker-custom-entrypoint.d/pre-default/*.sh; do
        if [[ -f "$f" && -x $(realpath "$f") ]]; then
          echo "Running $f"
          "$f"
        fi
      done
    fi
  fi

  for f in /docker-entrypoint.d/*.sh; do
    echo "Running $f"
    "$f"
  done

  if [ -d /docker-custom-entrypoint.d/ ]; then
    find /docker-custom-entrypoint.d/ -type f -name "*.sh" \
      -exec chmod +x {} \;
    sync
    for f in /docker-custom-entrypoint.d/*.sh; do
      if [[ -f "$f" && -x $(realpath "$f") ]]; then
        echo "Running $f"
        "$f"
      fi
    done
  fi
}

## Post startup handler
post_startup_handler() {
  if [ -d /docker-custom-entrypoint.d/ ]; then
    if [ -d /docker-custom-entrypoint.d/post-startup/ ]; then
      find /docker-custom-entrypoint.d/post-startup/ -type f -name "*.sh" \
        -exec chmod +x {} \;
      sync
      for f in /docker-custom-entrypoint.d/post-startup/*.sh; do
        if [[ -f "$f" && -x $(realpath "$f") ]]; then
          echo "Running $f"
          "$f"
        fi
      done
    fi
  fi
}

## Post execution handler
post_execution_handler() {
  if [ -d /docker-custom-entrypoint.d/ ]; then
    if [ -d /docker-custom-entrypoint.d/post-execution/ ]; then
      find /docker-custom-entrypoint.d/post-execution/ -type f -name "*.sh" \
        -exec chmod +x {} \;
      sync
      for f in /docker-custom-entrypoint.d/post-execution/*.sh; do
        if [[ -f "$f" && -x $(realpath "$f") ]]; then
          echo "Running $f"
          "$f"
        fi
      done
    fi
  fi
}

## Sigterm Handler
sigterm_handler() { 
  echoerr "Catching SIGTERM"
  if [ $pid -ne 0 ]; then
    echoerr "sigterm_handler for PID '${pid}' triggered"
    # the above if statement is important because it ensures 
    # that the application has already started. without it you
    # could attempt cleanup steps if the application failed to
    # start, causing errors.
    if [ -d /docker-custom-entrypoint.d/ ]; then
      if [ -d /docker-custom-entrypoint.d/sigterm-handler/ ]; then
        find /docker-custom-entrypoint.d/sigterm-handler/ -type f -name "*.sh" \
          -exec chmod +x {} \;
        sync
        for f in /docker-custom-entrypoint.d/sigterm-handler/*.sh; do
          if [[ -f "$f" && -x $(realpath "$f") ]]; then
            echo "Running $f"
            "$f"
          fi
        done
      fi
    fi
    kill -15 "$pid"
    wait "$pid"
    post_execution_handler
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

## Setup signal trap
# on callback execute the specified handler
trap sigterm_handler SIGTERM

## Initialization
pre_execution_handler

## Start Process
echoerr "Starting Puppetserver"
# run process in background and record PID
/opt/puppetlabs/bin/puppetserver "$@" &
pid="$!"

## Post Startup
post_startup_handler

## Wait forever until app dies
wait "$pid"
return_code="$?"

## Cleanup
post_execution_handler
# echo the return code of the application
exit $return_code
