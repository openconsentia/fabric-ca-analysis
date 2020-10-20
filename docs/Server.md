---
title: Server
nav_order: 2
---

# Server

Please refer to the official [User Guide][1] to learn more about the use of the tool.

When you spin up your local network you will find a docker container named `server-ca` hosting a [Fabric CA][1]. To help you manipulate the server, a script name [./deployments/query.sh](https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/scripts/query.sh) has been mounted in the container.

When you ssh into the container, and use the script `query.sh` to query the in-built database -- `sqlite`.

For advance operations, please refer to the official [Operations Guide][2]. Reconfigure the docker-compose `server ca` service to suit your experimentation goals.


[1]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-server

[2]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/operations_guide.html