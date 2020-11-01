#!/bin/bash

COMMAND=$1
SUBCOMMAND=$2
ARGS_NUM=$#

export ROOTCA_IMAGE=oc/rootca:current
export ICA_SERVER_IMAGE=oc/ica:current
export ICA_CLIENT_IMAGE=oc/icaclient:current
export PEER_CLIENT_IMAGE=oc/peerclient:current

function cleanNetwork(){
    stop
    docker-compose -f ./deployments/rootca-docker-compose.yaml rm
}

function cleanImages(){
    docker rmi -f $(docker images --filter "dangling=true" -q)
    docker rmi -f ${ROOTCA_IMAGE}
    docker rmi -f ${ICA_SERVER_IMAGE}
    docker rmi -f ${ICA_CLIENT_IMAGE}
    docker rmi -f ${PEER_CLIENT_IMAGE}
}

function run(){
    # Spin-up an instance of Root CA
    docker-compose -f ./deployments/rootca-docker-compose.yaml up -d rootca

    # Execute a script to register the intermediate CA on the Root CA via a dedicated
    # client known as `icaclient`. This will spin up and automatically shutdown after
    # execution of the registration script.
    docker-compose -f ./deployments/rootca-docker-compose.yaml run --rm icaclient sh -c './scripts/register-ica.sh'

    # Spin-up the intermediate CA
    docker-compose -f ./deployments/rootca-docker-compose.yaml up -d ica
}

function shall(){
    local cmd=$1
    case "$cmd" in
        ica)
            docker-compose -f ./deployments/rootca-docker-compose.yaml exec ica /bin/bash
            ;;
        peerclient)
            docker-compose -f ./deployments/rootca-docker-compose.yaml run --rm peerclient /bin/bash
            ;;
        rootca)
            docker-compose -f ./deployments/rootca-docker-compose.yaml exec rootca /bin/bash
            ;;
        *)
            echo "$0 $COMMAND [ica | peerclient | rootca]"
            ;;
    esac
}

function stop(){
    docker-compose -f ./deployments/rootca-docker-compose.yaml down
}

function status(){
    docker-compose -f ./deployments/rootca-docker-compose.yaml ps
}

case "$COMMAND" in
    clean)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 clean"
          exit 1
        fi
        cleanNetwork
        cleanImages
        ;;
    run)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 run"
          exit 1
        fi
        run
        ;;
    shell)
        if [ $ARGS_NUM -ne 2 ]; then
          echo "Usage: $0 shell [client | ica | rca]"
          exit 1
        fi
        shall $SUBCOMMAND
        ;;
    status)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 status"
          exit 1
        fi
        status
        ;;
    stop)
        if [ $ARGS_NUM -ne 1 ]; then
          echo "Usage: $0 stop"
          exit 1
        fi
        stop
        ;;
    *)
        echo "Usage: $0  Commands"
        echo "Commands: "
        echo "  clean"
        echo "  run"
        echo "  shell [ica | peerclient | rootca]"
        echo "  status"
        echo "  stop"
        ;;
esac