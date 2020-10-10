FROM hyperledger/fabric-ca:1.4.4

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

