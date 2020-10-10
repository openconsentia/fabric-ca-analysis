#!/bin/bash

args_number="$#"
admin="$1"

usage_message="Usage: $0 username"

function verifyArg() {

    if [ $args_number -ne 1 ]; then
        echo $usage_message
        exit 1;
    fi
}

verifyArg

echo
echo "========================================================="
echo "Enrolling this client with the following credentials"
echo "at fabric-ca-server:7050"
echo "========================================================="
echo
echo "  username: admin"
echo "  password: adminpw"
echo
fabric-ca-client enroll -u http://admin:adminpw@fabric-ca-server:7054
echo "Client enrolled!"
echo

echo
id_attrs='hf.Revoker=true,admin=true:ecert'
echo "====================================================="
echo "Registering a peer following a successful enrollment."
echo "====================================================="
echo
echo " id.type: peer"
echo " id.name: $admin"
echo " id.affliliation: org1.department1"
echo " id.attrs: '$id_attrs'"
echo
password=$(fabric-ca-client register --id.type peer --id.name $admin --id.affiliation org1.department1 --id.attrs $id_attrs) 

passwd=$(echo $password | awk '{print $2}')
echo $passwd

echo
echo "Expected user in database: "
echo " admin"
echo " admin2"
sqlite3 ./fabric-ca-home/fabric-ca-server.db "select * from users"


echo
echo "========================================================="
echo "Enrolling this client with the following credentials"
echo "at fabric-ca-server:7050"
echo "========================================================="
echo
echo "  username: $admin"
echo "  password: $passwd"
echo
fabric-ca-client enroll -u http://$admin:$passwd@fabric-ca-server:7054 -M misc
if [ $? -eq 0 ]; then
    echo "Client enrolled!"
else
    echo "Client not enrolled!"
fi
echo

echo
echo "Cert for $admin"
openssl x509 -in $FABRIC_CA_CLIENT_HOME/misc/signcerts/cert.pem -text -noout

echo
echo "==================================="
echo " Revoking                          "
echo "==================================="
echo
echo " username: $admin"
echo 
fabric-ca-client revoke -e $admin -r unspecified
echo

echo
echo "Expected: $admin revoked"
echo "Got:"
sqlite3 ./fabric-ca-home/fabric-ca-server.db "select * from certificates" | grep $admin

