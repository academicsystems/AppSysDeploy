#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: generate_ssl_script.sh [file name] [host name]";
  exit
fi

FNAME=${1}
HOSTNAME=${2}

# generate apache2 self signed certificates
openssl genrsa -des3 -passout pass:x -out ${FNAME}.pass.key 2048
openssl rsa -passin pass:x -in ${FNAME}.pass.key -out ${FNAME}.key
rm ${FNAME}.pass.key

openssl req -new -key ${FNAME}.key -out ${FNAME}.csr -subj "/CN=${HOSTNAME}"
openssl x509 -req -days 3650 -in ${FNAME}.csr -signkey ${FNAME}.key -out ${FNAME}.crt

