#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

echo "Running $@"
if [ "$(basename $1)" == "concourse" ]; then
    #
    exec concourse
else
    exec "$@"
fi
