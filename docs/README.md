# Overview

The objective of this project is to help anyone interested in [Fabric CA][1] appreciate its features and functionalities. 

## Prerequisite

You are expected to be familiar with the operations of `docker` and `docker-compose`.

## What is in this project?

* Docker-compose based deployments of [Fabric CA][1] with custom instrumentations located in this folder [./deployments/docker-compose.yaml](../deployments/docker-compose.yaml);

* A set of [bash shell scripts](../deployments/scripts) to help you interact with the [Fabric CA][1] deployments.

## How to use this project?

Please refer to scripts found in [./deployments](../deployments) to get information learn about orchestration and operations of [Fabric CA][1].
 
Use this project to perform these operations:

* Spin up a local network.

* Access the internals of [Fabric CA Client][2].

* Access the intermals of [Fabric CA Server][3].

#### Spin up a local network

Use this [./scripts/network.sh](../scripts/network.sh) to operate your local network of [Fabric CA][1] and supporting containers. 

Run the following commands:

* `./scripts/network.sh run` to spin up a local network.

* `./scripts/network.sh stop` to stop a running local network.

* `./scripts/network.sh status` to view the status of the containers in your network.

* `./scripts/network.sh clean` to remove docker containers and images from your machine. 

#### Access the internals of [Fabric CA Client][2]

Run the command `./scripts/shell.sh client` to access, via bash shell, the internals of [Fabric CA Client][2] in your network.

To help you appreciate the operations you can perform internally in [Fabric CA Client][2], please refer to these [scripts](../deployments/scripts), which are mounted as part of the client container.

#### Access the internal of [Fabric CA Server][3]

Run the command `./scripts/shell server` to access, via bash shell, the internals of [Fabric CA Server][3] in your network.

To help you appreciate the operations you can perform internally in [Fabric CA Server][3], please refer to these [scripts](../deployments/scripts), which are mounted as part of the server container.

## Copyright

Copyright 2020 Open Consentia Contributors.


[1]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/
[2]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-client
[3]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-server