#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

CWD="$(dirname $0)/"

. ${CWD}functions.sh

echo "=> Test concourse command"
docker run -t -i --name $TEST_NAME $TEST_CONTAINER /usr/local/bin/concourse --version
cleanup $TEST_NAME
