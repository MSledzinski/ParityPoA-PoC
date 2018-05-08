#!/bin/bash


ls /etc/poa-chain/


/parity/parity --config /etc/poa-chain/minimal-config.toml daemon 1234

sleep 10s

AUTHORITY_PASSPHRASE=$(cat /secrets/$AUTHORITY_COMPANY/passphrase)
AUTHORITY_PASSWORD=$(cat /secrets/$AUTHORITY_COMPANY/password)

AUTHORITY_ADDRESS=$(curl -X POST \
--data "{\"method\":\"parity_newAccountFromPhrase\",\"params\":[\"$AUTHORITY_PASSPHRASE\",\"$AUTHORITY_PASSWORD\"],\"id\":1,\"jsonrpc\":\"2.0\"}" \
-H "Content-Type: application/json" \
--silent \
127.0.0.1:8545 | jq -r '.result')


kill $(ps ax | grep "/parity/parity --config" | grep -v grep | awk '{ print $1 }');

sleep 5s

sed -i 's/AUTHORITY_ADDRESS/'$AUTHORITY_ADDRESS'/' /etc/poa-chain/node-config.toml
sed -i 's/AUTHORITY_COMPANY/'$AUTHORITY_COMPANY'/' /etc/poa-chain/node-config.toml

ls -al /secrets/one

/parity/parity --config /etc/poa-chain/node-config.toml \
    --jsonrpc-port=8545 \
    --port=30303 \
    --ws-port=8546 \
    --gasprice 0