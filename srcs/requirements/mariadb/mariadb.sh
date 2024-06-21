#!/bin/bash
chown -R mysql:mysql /var/lib/mysql

/usr/bin/mysql_safe --skip-networking &

while ! mysqladmin ping -hlocalhost -uroot -p"$ROOT_PWD" --silent; do
    sleep 1
done


if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    mysql -u root -p"$ROOT_PWD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8;"
    mysql -u root -p"$ROOT_PWD" -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PW';"
    mysql -u root -p"$ROOT_PWD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%'"
    mysql -u root -p"$ROOT_PWD" -e "FLUSH PRIVILEGES;"
    mysqladmin -p"$ROOT_PWD" -e root password $ROOT_PW
fi
mysqladmin -uroot -p"$ROO_PWD" shutdown