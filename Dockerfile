FROM resin/rpi-raspbian

RUN apt-get update && \
    apt-get install -y \
    openssl

RUN mkdir -p /etc/ssl/localcerts
 
CMD /usr/bin/openssl genrsa -out /etc/ssl/localcerts/${KEY_NAME}.key 1024 && \
    /usr/bin/openssl req  -new -newkey rsa:4096 -days 365 -nodes -subj "/C=/ST=/L=/O=/CN=${COMMON_NAME}" -keyout /etc/ssl/localcerts/${KEY_NAME}.key -out /etc/ssl/localcerts/${KEY_NAME}.csr  && \
    /usr/bin/openssl x509 -req -days 365 -in /etc/ssl/localcerts/${KEY_NAME}.csr -signkey /etc/ssl/localcerts/${KEY_NAME}.key -out /etc/ssl/localcerts/${KEY_NAME}.crt
