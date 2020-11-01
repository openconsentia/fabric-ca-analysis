#!/bin/bash

USERNAME=$1
ARG_NUM=$#

if [ $ARG_NUM -ne 1 ]; then
    echo "Usage: $0 <a user name to be registered>"
    exit 1
fi

echo
echo "========================================================="
echo "Enrolling this client with the following credentials"
echo "at ica:7050"
echo "========================================================="
echo
echo "  username: admin.ica"
echo "  password: adminpw"
echo
fabric-ca-client enroll -u http://admin.ica:adminpw@ica:7054
if [ $? != 0 ]; then
    echo "Failed"
    exit 1
else
    echo "Enrolled"
fi
echo

echo
id_attrs='hf.Revoker=true,admin=true:ecert'
echo "====================================================="
echo "Registering a peer following a successful enrollment."
echo "====================================================="
echo
echo " id.type: peer"
echo " id.name: $USERNAME"
echo " id.affliliation: org1.department1"
echo " id.attrs: '$id_attrs'"
echo
pword=$(fabric-ca-client register --id.name $USERNAME \
                          --id.type user \
                          --id.affiliation org1.department1 \
                          --id.attrs $id_attrs)
if [ $? != 0 ]; then
    echo "Failed"
    exit 1
else
    echo "Registered"
fi
echo


echo "====================================================="
echo "Enrolling a $USERNAME with password $pword_1"
echo "====================================================="
fabric-ca-client enroll -u http://"$USERNAME":"${pword:10}"@ica:7054
