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
        docker-compose -f ./deployments/docker-compose.yaml up -d
        ;;
    status)
        docker-compose -f ./deployments/docker-compose.yaml ps
        ;;
    stop)
        docker-compose -f ./deployments/docker-compose.yaml down
        ;;
    *)
        echo "$0  clean | run | stop "
        ;;
esac