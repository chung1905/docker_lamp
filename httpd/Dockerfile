FROM httpd:2.4

# Create non-root user
#ARG USER_NAME
#ARG UID
#RUN useradd -m -U ${USER_NAME} -u ${UID} -p1 -s /bin/bash -G root -o
#ENV APACHE_RUN_USER ${USER_NAME}
#ENV APACHE_RUN_GROUP ${USER_NAME}

# Add custom conf file
RUN echo "Include /usr/local/apache2/conf/docker/httpd.conf" >> /usr/local/apache2/conf/httpd.conf;
