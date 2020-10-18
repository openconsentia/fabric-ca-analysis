#!/bin/bash

COMMAND=$1

crypto_dir=./deployments/crypto

##
## This operation use openssl to generate private keys and certificate.
## The artefacts are stored in generated folder `./crypto`
##
function cert(){
    clean
    mkdir -p $crypto_dir
    openssl genrsa -out $crypto_dir/secrets.key 1024
    openssl rsa -in $crypto_dir/secrets.key -out $crypto_dir/public.key -pubout -outform PEM
    openssl req -new -key $crypto_dir/secrets.key -out $crypto_dir/network.csr -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=server-ca"
    openssl x509 -signkey $crypto_dir/secrets.key -in $crypto_dir/network.csr -req -days 365 -out $crypto_dir/network-cert.pem 
}

function clean(){
    rm -rf $crypto_dir
}

case "$COMMAND" in
    cert)
        cert
        ;;
    clean)
        clean
        ;;
    *)
        echo "$0 cert | clean"
        ;;
esac