---
layout: default
title: Home
nav_order: 1
permalink: /
---

# Open Consentia's Fabric CA Analysis

The objective of this project is to create a platform for anyone interested in [Fabric CA][1] to learn about the technology through experimentation.

## Prerequisite

The platform uses `docker` (or `docker-compose`). 

Unfortunately it is beyond the scope of this project to explain the inner working of the technology. You are expected to be familiar with this technology and have already installed this in order to use this platform.

## What is in this project?

Clone this [GitHub repository](https://github.com/openconsentia/fabric-ca-analysis).

In the repo, you will find the following artefacts:

* Customised docker images and scripts with instrumentations to help you interact with a deployment of [Fabric CA][fabric-ca];

* Docker-compose based deployments of [Fabric CA][fabric-ca] with custom instrumentations.

## How to use this project?

Out-of-the-box you will find the following deployment scenarios:

* [Scenario 1][tls]: Using TLS to secure comminications between a [Fabric CA Client][fabric-ca-client] and a [Fabric CA Server][fabric-ca-server].

* [Scenario 2][register]: Enroll, register and revoke identities.

## Copyright

Copyright 2020 Open Consentia Contributors.


[fabric-ca]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/
[fabric-ca-client]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-client
[fabric-ca-server]: https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/users-guide.html#fabric-ca-server

[tls]: https://openconsentia.github.io/fabric-ca-analysis/tls.html
[register]: https://openconsentia.github.io/fabric-ca-analysis/register.html