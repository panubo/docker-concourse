#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

echo "Running $@"
if [ "$(basename $1)" == "concourse" ]; then

    if [ "$2" == "web" ]; then
        PG_CONN="postgres://${POSTGRES_ENV_POSTGRES_USER}:${POSTGRES_ENV_POSTGRES_PASSWORD}@${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/${POSTGRES_ENV_POSTGRES_USER}?sslmode=disable"
        exec "$@" --postgres-data-source="$PG_CONN"
    else
        # worker or other
        # NB. Currently worker doesn't function in docker.
        exec "$@"
    fi
else
    exec "$@"
fi
