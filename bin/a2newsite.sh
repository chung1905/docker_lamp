#!/bin/bash

BASEDIR=$(dirname "$0")
SITESDIR=${BASEDIR}/../php-apache/apache2/sites-available

read -p "ServerName (site URL, eg. example.local): " serverName
read -p "DocumentRoot (eg. /var/www/html/example): " documentRoot
read -p "Config filename (eg. example): " filename
read -p "Enable SSL? (y/n): " isSSL

if [[ $isSSL = 'y' ]]
then
    tempKeyFile="${BASEDIR}/temp.key"
    tempPemFile="${BASEDIR}/temp.pem"

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $tempKeyFile -out $tempPemFile

    read -p "SSL Certificate file name: " sslFilename
    read -p "Repeat Email: " email

    mv $tempKeyFile ${BASEDIR}/../php-apache/ssl/private/${sslFilename}.key
    mv $tempPemFile ${BASEDIR}/../php-apache/ssl/certs/${sslFilename}.pem

    cat ${SITESDIR}/000-default.conf > ${SITESDIR}/${filename}.conf
    cat ${SITESDIR}/example-ssl.conf >> ${SITESDIR}/${filename}.conf
    
    sed -i \
        -e "s/webmaster@localhost/${email}/g" \
        -e "s/ssl.local/${serverName}/g" \
        -e "s/example-ssl/${sslFilename}/g" \
        -e "s/www.example.com/${serverName}/g" \
        -e "s?/var/www/html?${documentRoot}?g" \
        -e "s/#ServerName/ServerName/g" \
        ${SITESDIR}/${filename}.conf
else 
    sed -e "s/www.example.com/${serverName}/g" \
    -e "s?/var/www/html?${documentRoot}?g" \
    -e "s/#ServerName/ServerName/g" \
    < ${SITESDIR}/000-default.conf \
    > ${SITESDIR}/${filename}.conf
fi

docker exec php71 a2ensite ${filename}
docker exec php71 service apache2 reload