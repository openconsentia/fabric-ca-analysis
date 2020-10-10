#!/bin/bash

sqlite3 /etc/hyperledger/fabric-ca-server/fabric-ca-server.db "select * from users"