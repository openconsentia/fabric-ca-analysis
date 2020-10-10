#!/bin/bash

COMMAND=$1

function client(){
    docker-compose -f ./deployments/docker-compose.yaml exec client-ca /bin/bash
}

function server(){
    docker-compose -f ./deployments/docker-compose.yaml exec server-ca /bin/bash
}

message="$0 client | server"

case "$COMMAND" in
    client)
        client
        ;;
    server)
        server
        ;;
    *)
        echo $message
        ;;
esac