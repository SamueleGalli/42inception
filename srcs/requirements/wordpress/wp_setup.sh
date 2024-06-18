#creo cartella run/php
mkdir -p /run/php

#faccio aspettare a MYSQL 5 secondi di continuo finche non e disponibile il server
while ! mysql -h mariadb -u $DB_USER -p$DB_PW $DB_NAME -e "SELECT 'OK' AS status;"; do
    sleep 5
done
#controlla se il file wp-config.php non esite
#se non esiste copia i file di wordpress configura wordpress con dbhost dbname dbuser dbpass
#istalla wordpress con i dettagli specificati e cre un utente author
if [! -f /var/www/wordpress/wp-config.php];
    cp -R /usr/src/wordpress /var/www
    wp core config --path=/var/www/wordpress --dbhost=${DB_HOST} --dbname${DB_NAME} --dbuster=${DB_USER} --dbpass=${DB_PW} --allow-root
    wp core install --path=/var/www/wordpress --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_N} --admin_password=${WP_ADMIN_PW} --admin_email=${WP_ADMIN_MAIL} --skip-email
    wp core install --path=/var/www/wordpress --allow-root ${WP_USER} ${WP_USER_EMAIL} --role=author --user_pass=${WP_USER_PW}
fi
#esegue php in background
/user/sbin/php-fpm7.3 --nodaemonize