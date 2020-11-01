FROM hyperledger/fabric-ca:1.4.4 as base

FROM ubuntu

COPY --from=base /usr/local/bin/fabric-ca-server /usr/local/bin/fabric-ca-server
COPY --from=base /usr/local/bin/fabric-ca-client /usr/local/bin/fabric-ca-client

RUN apt-get update && apt-get install -y --no-install-recommends \
      g++ \
      gcc \
      libtool \
      libltdl-dev \
      golang-go \
      git \
      openssl \
      ca-certificates \
      sqlite3

