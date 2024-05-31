#!/bin/bash

set -e

puppet config set --section server environmentpath $ENVIRONMENTPATH
