#!/bin/bash

COMMAND=$1

export SERVER_IMAGE_NAME=oc/ca-server

# Network operations
function cleanServer(){
    rm -rf ./deployments/fabric-ca-server-home/msp
    rm -f ./deployments/fabric-ca-server-home/ca-cert.pem
    rm -f ./deployments/fabric-ca-server-home/fabric-ca-server.db
    rm -f ./deployments/fabric-ca-server-home/IssuerPublicKey
    rm -f ./deployments/fabric-ca-server-home/IssuerRevocationPublicKey
}

function cleanClient(){
    rm -rf ./deployments/fabric-ca-client-home/msp
}

function cleanNetwork(){
    docker-compose -f ./deployments/docker-compose.yaml down
    rm -rf ./deployments/fabric-tlsca-server
}

function cleanImages(){
    docker rmi -f $(docker images --filter "dangling=true" -q)
    docker rmi -f ${SERVER_IMAGE_NAME}
}

function run(){
    docker-compose -f ./deployments/docker-compose.yaml up -d
}

function stop(){
    docker-compose -f ./deployments/docker-compose.yaml down
}

case "$COMMAND" in
    clean)
        ./scripts/crypto.sh clean
        cleanClient
        cleanServer
        cleanNetwork
        cleanImages
        ;;
    run)
        ./scripts/crypto.sh cert
        run
        ;;
    stop)
        stop
        ;;
    *)
        echo "$0  clean | client | run | server | stop "
        ;;
esac