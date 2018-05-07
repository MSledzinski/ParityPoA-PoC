#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "bad number of params - $#, expected 2 - passphrase and password"
    exit 1
fi

PASSPHRASE=$1
PASSWORD=$2

pa_run=$(docker ps | grep parity-node-min)

if [[ -z "$pa_run" ]]; then
    ./docker/run-docker-min.sh
fi


curl -X POST \
--data "{\"method\":\"parity_newAccountFromPhrase\",\"params\":[\"$PASSPHRASE\",\"$PASSWORD\"],\"id\":1,\"jsonrpc\":\"2.0\"}" \
-H "Content-Type: application/json" \
--silent \
localhost:8545 | jq -r '.result'

