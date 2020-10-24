---
title: Identities management
nav_order: 3
---

# Enrolling, registering and revoking identities

When you spin up the network, you will find a container named `client-ca` hosting a cli based app name `fabric-ca-client`. For details on the use of the app, please refer to the [User Guide][user-guide] for detail operations.

In this project, the `client-ca` container has two scripts mounted:

* [./deployments/scripts/registering-admin2.sh][register];

* [./deployments/scripts/revoke-identity.sh][revoke].

Use these scripts to perform identities management.

## Registring an entity named `admin2`

In this scenario, the script invokes the `fabric-ca-client` to enroll the client using a bootstrap identity `admin@adminpw` pre-registered in the server. The enroll identity register a new identity named `admin2` and its associated organisational affliation. This has the effect of collecting the necessary certificates and keys, and storing it in a folder call `msp` -- i.e. a kind of cryptographic wallet i.e. `/deployments/fabric-ca-client-home/msp`.

These are the step to run this scenario, assuming you already have a running network:

1. Run the command `./script/shell.sh client`.

1. In your shell, run the command `./registering-admin2.sh`

If you like to see if your new identity is being registered in the server end, open another terminal (`./script/shell.sh server`) into the server and query the database. You should see the identity as shown below:

```
admin|$2a$10$ViiNsOOb5sFZbCGzqofhhuO/9OhnSjxjLEsHu.jE6RLlNwmJavrl.|client||[{"name":"hf.IntermediateCA","value":"1"},{"name":"hf.GenCRL","value":"1"},{"name":"hf.Registrar.Attributes","value":"*"},{"name":"hf.AffiliationMgr","value":"1"},{"name":"hf.Registrar.Roles","value":"*"},{"name":"hf.Registrar.DelegateRoles","value":"*"},{"name":"hf.Revoker","value":"1"}]|1|-1|2|0
admin2|$2a$10$qHrVYdFct7eVPhVk8JFtRugytEXTmO5mnZwnlIml4vR1cKk9mgsvq|peer|org1.department1|[{"name":"hf.Revoker","value":"true"},{"name":"admin","value":"true","ecert":true},{"name":"hf.EnrollmentID","value":"admin2","ecert":true},{"name":"hf.Type","value":"peer","ecert":true},{"name":"hf.Affiliation","value":"org1.department1","ecert":true}]|0|-1|2|0
```

**NOTE:** The server in this deployment uses `sqlite` db to store identities. You can replace this with other database, please refer to the official [operations guide][ops-guide].

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

1. You may need to remove the the folder `fabric-ca-client-home/msp` between each scenario to ensure that your are generating new artefacts.

1. The app `fabric-ca-client` is use to create the `msp` and to interact with the server.

1. If you were using this in the context of a Hyperledger Fabric application, you would be using an SDK instead of the `fabric-ca-client`.

[user-guide]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-client
[ops-guide]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/operations_guide.html

[register]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/scripts/registering-admin2.sh
[revoke]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/scripts/revoke-identity.sh