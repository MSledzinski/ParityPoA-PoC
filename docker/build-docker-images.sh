docker build -f ./Dockerfile-base -t parity-poa-chain-base:v1.10.2 .

docker build -f ./Dockerfile-min -t parity-poa-chain-min:v1.10.2 .

docker build -f ./Dockerfile-node -t parity-poa-chain-node:v1.10.2 .
