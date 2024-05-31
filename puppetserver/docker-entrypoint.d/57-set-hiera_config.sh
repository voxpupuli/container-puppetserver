#!/bin/bash

set -e

puppet config set --section server hiera_config $HIERACONFIG
