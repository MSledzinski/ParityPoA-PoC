getEnode() {
    local URL=$1

    curl --data '{"jsonrpc":"2.0","method":"parity_enode","params":[],"id":0}' -H "Content-Type: application/json" -X POST $URL --silent | jq -r '.result'
}

setNodes() {
    local NODE_URL=$1
    local PEER_ENODE=$2

    curl -X POST --data "{\"jsonrpc\":\"2.0\",\"method\":\"parity_addReservedPeer\",\"params\":[\"$PEER_ENODE\"],\"id\":0}" \
     -H "Content-Type: application/json" $NODE_URL
}

RPC_PORT=8545

# get enode onde
NODE_ONE_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' paritypoapoc_parity-node-one_1)
NODE_ONE_ENODE=$(getEnode "$NODE_ONE_IP:$RPC_PORT")

echo "Enode One: $NODE_ONE_ENODE"

# get enode two
NODE_TWO_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' paritypoapoc_parity-node-two_1)
NODE_TWO_ENODE=$(getEnode "$NODE_TWO_IP:$RPC_PORT")

echo "Enode Two: $NODE_TWO_ENODE"

# get enode three
NODE_THREE_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' paritypoapoc_parity-node-three_1)
NODE_THREE_ENODE=$(getEnode "$NODE_THREE_IP:$RPC_PORT")

echo "Enode Three: $NODE_THREE_ENODE"

# add one->two
echo "Peer One-Two"
setNodes "$NODE_ONE_IP:$RPC_PORT" "$NODE_TWO_ENODE"

# add two->three
echo "Peer Two-Three"
setNodes "$NODE_TWO_IP:$RPC_PORT" "$NODE_THREE_ENODE"

# add one->three
echo "Peer One-Three"
setNodes "$NODE_ONE_IP:$RPC_PORT" "$NODE_THREE_ENODE"