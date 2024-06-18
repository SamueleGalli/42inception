#cambia il proprietario e il gruppo di /var/lib/mysql a mysql:mysql 
chown -R mysql:mysql /var/lib/mysql
#controllo se la direcory /var/lib.ect esiste altrimenti avvio il servizio mysql
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    systemclt start mysql
    #creo il database se non esite e uso il set di caratteri forntin da utf
    mysql -u root -p"$ROOT_PWD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8;"
    #creo l'utente del database con nome e password
    mysql -u root -p"$ROOT_PWD" -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PW';"
    #concedo i privilegi all'utente
    mysql -u root -p"$ROOT_PWD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%'"
    #applico i cambiamenti sui privilegi
    mysql -u root -p"$ROOT_PWD" -e "FLUSH PRIVILEGES;"
    #imposto la password di root mysql a root_pw
    mysqladmin -p"$ROOT_PWD" -e root password $ROOT_PW
    #fermo il servizio mysql
    systemclt stop mysql
fi
#avvio mysql in modo sicuro
/user/bin/mysqld_safe