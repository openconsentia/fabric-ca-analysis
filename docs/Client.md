---
title: Client
nav_order: 3
---

When you spin up the network, you will find a container named `client-ca` hosting a cli based app name `fabric-ca-client`. For details on the use of the app, please refer to the [User Guide][1] for detail operations.

In this project, the `client-ca` container has two scripts mounted:

* [./deployments/scripts/registring-admin2.sh][2];

* [./deployments/scripts/revoke-identity.sh][3].


## Registring an entity named `admin2`

In this scenario, the script invokes the `fabric-ca-client` to enroll the client using a bootstrap identity `admin@adminpw` pre-registered in the server. The enroll identity register a new identity named `admin2` and its associated organisational affliation. This has the effect of collecting the necessary certificates and keys, and storing it in a folder call `msp` -- i.e. a kind of cryptographic wallet i.e. `/deployments/fabric-ca-client-home/msp`.

These are the step to run this scenario, assuming you already have a running network:

1. Run the command `./script/shell.sh client`.

1. In your shell, run the command `./registering-admin2.sh`

If you like to see if your new identity is being registered in the server end, open another terminal (`./script/shell.sh server`) into the server and query the database.

## Revoking identity

In this scenario, the script uses the `fabric-ca-client` to enroll with the bootstrap identity. You are presented with a choice to register a new identity with rights to revoke . The script will use the new identity to enroll to the server, and then revoke itself from the server. The end result could look some thing like this:

```
===================================
 Revoking                          
===================================

 username: test

2020/10/19 18:21:42 [INFO] Configuration file location: /opt/fabric-ca-client-home/fabric-ca-client-config.yaml
2020/10/19 18:21:42 [INFO] TLS Enabled
2020/10/19 18:21:42 [INFO] TLS Enabled
2020/10/19 18:21:42 [INFO] Sucessfully revoked certificates: [{Serial:7954a8d339c19dc8072f90a24f1b0d26f4f49d4b AKI:6e72d480960bc636726284e47ca100b09f2c0f26}]
```

These are the step to run this scenario, assuming you already have a running network:

1. Run the command `./script/shell.sh client`.

1. In your shell, run the command `./revoke-identity.sh <user name of your choice>`

## Note

1. You may need to remove the the folder `fabric-ca-client-home/msp` between each scenario

1. The app `fabric-ca-client` is use to create the `msp` and to interact with the server.

1. If you were using this in the context of a Hyperledger, you would be using an SDK instead of the `fabric-ca-client`.

[1]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-client
[2]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/scripts/registring-admin2.sh
[3]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/scripts/revoke-identity.sh