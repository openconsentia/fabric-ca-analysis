#!/bin/bash

COMMAND=$1
SUBCOMMAND=$2
ARGS_NUM=$#

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
    docker-compose -f ./deployments/tls-docker-compose.yaml down
    docker-compose -f ./deployments/tls-docker-compose.yaml rm
    rm -rf ./deployments/fabric-tlsca-server
    rm -rf ./deployments/fabric-ca-server-home
    rm -rf ./deployments/fabric-ca-client-home
}

function cleanImages(){
    docker rmi -f $(docker images --filter "dangling=true" -q)
    docker rmi -f ${SERVER_IMAGE_NAME}
}

function shallCommand(){
    local cmd=$1
    case "$cmd" in
        client)
            docker-compose -f ./deployments/tls-docker-compose.yaml exec client-ca /bin/bash
            ;;
        server)
            docker-compose -f ./deployments/tls-docker-compose.yaml exec server-ca /bin/bash
            ;;
        *)
            echo "$0 $COMMAND [client | server]"
            ;;
    esac
}

case "$COMMAND" in
    clean)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 clean"
          exit 1
        fi
        ./scripts/crypto.sh clean
        cleanClient
        cleanServer
        cleanNetwork
        cleanImages
        ;;
    run)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 run"
          exit 1
        fi
        ./scripts/crypto.sh cert
        docker-compose -f ./deployments/tls-docker-compose.yaml up -d
        ;;
    shell)
        if [ $ARGS_NUM -ne 2 ]; then
          echo "Usage: $0 shell [client | server]"
          exit 1
        fi
        shallCommand $SUBCOMMAND
        ;;
    status)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 status"
          exit 1
        fi
        docker-compose -f ./deployments/tls-docker-compose.yaml ps
        ;;
    stop)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 stop"
          exit 1
        fi
        docker-compose -f ./deployments/tls-docker-compose.yaml down
        ;;
    *)
        echo "Usage: $0  Commands"
        echo "Commands: "
        echo "  clean"
        echo "  run"
        echo "  shell [client | server]"
        echo "  status"
        echo "  stop"
        ;;
esac