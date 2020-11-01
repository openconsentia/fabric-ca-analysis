#!/bin/bash

fabric-ca-client enroll -u http://admin.root:adminpw@rootca:7054

fabric-ca-client register --id.name ica \
                          --id.type client \
                          --id.secret adminpw \
                          --id.attrs '"hf.IntermediateCA=true"' \
                          -m ica \
                          -u http://rootca:7054
