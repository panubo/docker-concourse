#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

CWD="$(dirname $0)/"

. ${CWD}functions.sh

echo "=> Test concourse web startup"
WORK_DIR="$(pwd)/data"
mkdir -p $WORK_DIR && pushd $WORK_DIR
ssh-keygen -t rsa -f host_key -N ''
ssh-keygen -t rsa -f worker_key -N ''
ssh-keygen -t rsa -f session_signing_key -N ''
cp -a worker_key authorized_worker_keys
docker run -d --name postgres -e POSTGRES_PASSWORD="password" -e POSTGRES_USER="concourse" postgres > /dev/null
docker run -d --name $TEST_NAME --link postgres -v $WORK_DIR:$WORK_DIR $TEST_CONTAINER -p 8080:8080 concourse web \
  --basic-auth-username test \
  --basic-auth-password test \
  --session-signing-key=$WORK_DIR/session_signing_key \
  --tsa-authorized-keys=$WORK_DIR/authorized_worker_keys \
  --tsa-host-key=$WORK_DIR/host_key
wait_on_http 30 http://localhost:8080
# Cleanup
cleanup postgres $TEST_NAME
rm -rf $WORK_DIR
