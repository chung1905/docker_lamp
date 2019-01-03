#!/bin/bash

tempKeyFile="temp.key"
tempPemFile="temp.pem"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $tempKeyFile -out $tempPemFile

read -p "SSL Certificate file name:" filename

mv $tempKeyFile ../php-apache/ssl/private/${filename}.key
mv $tempPemFile ../php-apache/ssl/certs/${filename}.pem