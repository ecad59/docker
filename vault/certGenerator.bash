#!bin/bash

export $(cat .env | xargs | tr -d '\r')

openssl req -x509 -out ssl/tls.crt -new -keyout ssl/tls.key -newkey rsa:4096 -nodes -sha256 -x509 -subj "/C=$COUNTRY/ST=$REGION/L=$CITY/O=$ORGNAME/OU=$ORGUNIT/CN=$CN/emailAddress=$EMAIL" -addext "subjectAltName=$SAN" -days 365
openssl req -x509 -out ssl/tls.crt -new -keyout ssl/tls.key -newkey rsa:4096 -nodes -sha256 -x509 -subj "/C=$COUNTRY/ST=$REGION/L=$CITY/O=$ORGNAME/OU=$ORGUNIT/CN=$CN/emailAddress=$EMAIL" -addext "subjectAltName=$SAN" -days 365