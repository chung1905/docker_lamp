FROM httpd:2.4-alpine

# Add custom conf file
RUN echo "Include /usr/local/apache2/conf/docker/httpd.conf" >> /usr/local/apache2/conf/httpd.conf

# Increase Timeout to 2h
RUN sed -i -e "s/Timeout 60/Timeout 7200/" /usr/local/apache2/conf/extra/httpd-default.conf
RUN sed -i -e "s?#Include conf/extra/httpd-default.conf?Include conf/extra/httpd-default.conf?" /usr/local/apache2/conf/httpd.conf
