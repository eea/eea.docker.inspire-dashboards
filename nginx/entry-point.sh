#!/bin/sh
# generate self signed ssl cert only if all cert files are empty or nonexistent

mkdir -p /etc/nginx/private/
mkdir -p /etc/nginx/certs/

if [ -z "${SSL_CERTS_DIR}" ] || [ -z "${SSL_PUB}" ] || [ -z "${SSL_KEY_DIR}" ] || [ -z "${SSL_PRIV}" ]; then

  echo "Generating self-signed SSL certificates"

  apk update && apk add --no-cache openssl

  mkdir -p /certs

  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /certs/priv.key -out /certs/cert.crt \
  -subj "/C=DK/ST=Copenhagen/L=Copenhagen/O=EEA/OU=IT Department/CN=inspire-dashboard.eea"

  cp /certs/priv.key /etc/nginx/private/
  cp /certs/cert.crt /etc/nginx/certs/
  rm -rf /certs

else
    echo "Skipping SSL certificate generation"

    cp /tmp/priv.key /etc/nginx/private/
    cp /tmp/cert.crt /etc/nginx/certs/

fi

echo "Starting nginx"

nginx -g "daemon off;"
