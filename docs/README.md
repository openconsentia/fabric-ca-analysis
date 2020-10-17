# Overview

The objective of this project is to help anyone interested in [Fabric CA][1] appreciate its features and functionalities. 

## Prerequisite

You will need to install Docker and docker-compose.

## What is in this project?

This project includes:

1. Docker-compose based deployments of [Fabric CA][1] with custom instrumentations located in this folder [./deployments/docker-compose.yaml](../deployments/docker-compose.yaml);

1. A set of [bash shell scripts](../deployments/scripts) to help you interact with the [Fabric CA][1] deployments.

## How to use this project?

Use this project to perform these operations:

* Spin up a local network.

* Access the internals of [Fabric CA Client][2].

* Access the intermals of [Fabric CA Server][3].

#### Spin up a local network

Use this [./scripts/network.sh](../scripts/network.sh) to operate your local network of [Fabric CA][1] containers. Run the following commands:

* `./scripts/network.sh run` to spin up a local network.

* `./scripts/network.sh stop` to stop a running local network.

* `./scripts/network.sh status` to view the status of the containers in your network.

* `./scripts/network.sh clean` to remove docker containers and images from your machine. 

#### Access the internals of [Fabric CA Client][2]

Run the command `./scripts/shell.sh client` to access, via bash shell, the internals of [Fabric CA Client][2] in your network.

#### Access the internal of [Fabric CA Server][3]

Run the command `./scripts/shell server` to access, via bash shell, the internals of [Fabric CA Server][3] in your network.

## Copyright

Copyright 2020 Open Consentia Contributors.


[1]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/
[2]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-client
[3]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-server