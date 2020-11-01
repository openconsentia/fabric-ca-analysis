---
title: Multiple Fabric CAs 
nav_order: 4
---

# Setting up a network with multiple Fabric CAs

Please refer to the official [user guide][user-guide] for explanation on setting up a multiple Fabric CA network. 

To relate to help you related to the official documentation, please refer to this [docker compose network][docker-compose] and this [operational script][rootca-run] for an simple example illustrating a network comprising of an intermediate and root Fabric CA, with simulated `Fabric CA` clients acting as:

* an command line orchestrator to register an intermediate CA.
* an end command line interface to interact with the intermediate CA.

In this demonstrator, you will see all artefacts built based on Ubuntu platform albeit in Docker form.

## Out-of-the-box

Out of the box you will find a network comprising of:

* A root CA instance provisioned using this [configuration file][root-ca-config].

* An intermediate CA instance provisioned using this [configuration file][ica-config] working inconjunction with a client known as `icaclient`.

* An [intermediate CA script][register-ica] responsible for registering the intermediate CA.

* A simulated peer client provision with this [configuration file][peer-config].

**NOTE:** 

* You may use [server cli][server-cli] and [client cli][client-cli] to provision the servers and client respectively instead of using configuration files.

### Network operations

Please study the [operational script][rootca-run] and follow this steps this spin-up and spin-down the demonstrator:

* `./scripts/rootca-scenario.sh run` to spin up the network.

* `./scripts/rootca-scenario.sh [stop | clean]` to spin down the network.

### Inspecting the internals of the CA servers and client

When the network is up a running you can access the internals of the root and immediate CA, and learn to use `fabric-ca-client` to interact with the intermediate CA. Follow these commands:

* `./scipts/rootca-scenario.sh shell rootca` -- to view the internals of the root CA.

* `./scipts/rootca-scenario.sh shell ica` -- to view the internals of the intermediate CA.

* `./scipts/rootca-scenario.sh shell peerclient` -- to give you access to a client cli.

### `rootca` Certificate

In the `rootca`, navigate to the location `/opt/fabric-ca-server` and you will find the file `ca-cert.pem`.

Run the command `openssl x509 -in ca-cert.pem -text -noout` and you will see a certificate issued by this simulated entity:
```
Issuer: C = GB, ST = England, L = London, O = "Open Consentia, England", OU = Root CA management team, CN = rootca
```

This root certificate is used to sign the intermediate CA certificate. 

### `ica` Certificate

In the `ica`, navigate to the location `/opt/fabric-ca-server` and you will find these files:

* `ca-cert.pem` the `ica` certificate.

* `ca-chain.pem` showing a chain of certificate leading to the `rootca`.

Run `openssl` cli against these files. In the case of `ca-cert.pem` you will find these:

* Issuer: `C = GB, ST = England, L = London, O = "Open Consentia, England", OU = Root CA management team, CN = rootca` indicates the credentials of `rootCA` as the signer of the `ica` cert.

* Subject: `C = GB, ST = Wales, L = Cardiff, O = "Open Consentia, Wales", OU = client, CN = ica` indicates the credentials of the `ica`

### `peer client`

When you access the peer client, run the command `./scripts/register-user-no-tls.sh <name of your choice>` to register a user named `<name of your choice>` in the `ica`. It will also then enroll the user in the `peer client`.

Navigate to this location `/opt/fabric-ca-client-home/msp/signcerts` and you will see this `cert.pem`. Run the `openssl` to inspect the certificate, which you will find these fields:

* Issuer: `C = GB, ST = Wales, L = Cardiff, O = "Open Consentia, Wales", OU = client, CN = ica`, which is the credentials used to sign `ica` cert.

* Subject: `C = GB, ST = Scotland, L = Edinburgh, O = "Open Consentia, Scotland", OU = user + OU = org1 + OU = department1, CN = test` which is the credential for the `ica` cert.

### Disclaimer

The credentials presented here are for illustrative prupose only and are not real organisational units of the Open Consentia enterprise.

[user-guide]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#setting-up-multiple-cas
[server-cli]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/servercli.html
[client-cli]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/clientcli.html

[docker-compose]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/rootca-docker-compose.yaml
[rootca-run]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/scripts/rootca-scenario.sh
[ca-server]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/server.dockerfile
[register-ica]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/scripts/register-ica.sh
[root-ca-config]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/ca-root-config/root/fabric-ca-server-config.yaml
[ica-config]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/ca-root-config/ica/fabric-ca-server-config.yaml
[peer-config]: https://github.com/openconsentia/fabric-ca-analysis/blob/master/deployments/ca-root-config/peer/fabric-ca-client-config.yaml