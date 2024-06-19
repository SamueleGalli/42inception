FROM debian:buster

RUN     apt-get update -y && \
        apt-get install -y \
        curl \
        php7.3 \
        php-mysql \
        php-fpm \
        mariadb-client &&\
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

RUN     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar &&\
        mkdir -p /usr/local/bin &&\
        mv wp-cli.phar /usr/local/bin/wp && \
        wp core download --path=/usr/src/wordpress --allow-root

COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN chmod 664 /etc/php/7.3/fpm/pool.d/www.conf

COPY wp_setup.sh /

RUN chmod +x /wp_setup.sh

VOLUME [ "/var/www/" ]

EXPOSE 9000

CMD ["/wp_setup.sh"]