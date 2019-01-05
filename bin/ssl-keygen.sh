#!/bin/bash

BASEDIR=$(dirname "$0")

tempKeyFile="${BASEDIR}/temp.key"
tempPemFile="${BASEDIR}/temp.pem"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $tempKeyFile -out $tempPemFile

read -p "SSL Certificate file name:" filename

mv $tempKeyFile ${BASEDIR}/../php-apache/ssl/private/${filename}.key
mv $tempPemFile ${BASEDIR}/../php-apache/ssl/certs/${filename}.pem