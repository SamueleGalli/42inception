chown -R mysql:mysql /var/lib/mysql
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    systemclt start mysql
    mysql -u root -p"$ROOT_PWD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8;"
    mysql -u root -p"$ROOT_PWD" -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PW';"
    mysql -u root -p"$ROOT_PWD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%'"
    mysql -u root -p"$ROOT_PWD" -e "FLUSH PRIVILEGES;"
    mysqladmin -p"$ROOT_PWD" -e root password $ROOT_PW
    systemclt stop mysql
fi
/user/bin/mysqld_safe