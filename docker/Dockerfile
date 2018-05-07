FROM parity/parity:v1.10.2

RUN apt-get update && apt-get install curl -y

RUN mkdir -p /mnt/io.parity.ethereum

VOLUME ["/mnt/io.parity.ethereum"]

RUN mkdir -p /etc/poa-chain

ADD ./configs/ /etc/poa-chain/

ADD ./scripts/ /scripts

# For the signer
RUN mkdir -p ~/.local/share/io.parity.ethereum/signer

ENTRYPOINT ["/scripts/entrypoint.sh"]