FROM debian:bullseye

RUN     apt update -y &&\
        apt install -y nginx openssl && \
        rm -rf /var/lib/apt/lists/*

COPY config.conf /etc/nginx/sites-available/default

RUN openssl req -newkey rsa:2048 -nodes -x509 -days 365 \
        -subj "/C=IT/ST=Firenze/L=Firenze/O=sgalli/CN=sgalli.42.fr" \
        -keyout /etc/ssl/key.key \
        -out /etc/ssl/cert.cert && \
        chmod 600 /etc/ssl/* \
        && chown -R root:root /etc/ssl/*

RUN chown -R www-data /var/www/

VOLUME [ "/var/www/" ]

EXPOSE 443

CMD ["nginx","-g","daemon off;"]