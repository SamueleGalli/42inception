COMPOSE_FILE=srcs/docker-compose.yml
WORDPRESS_DATA_DIR=/home/sgalli/data/wordpres_data
MARIADB_DATA_DIR=/home/sgalli/data/mariadb_data
all:
#prima di tuttoaggiorno le immagini dei container
#avvio docker compose dentro la cartella usando la build corretta e lo metto in background
	docker-compose -f $(COMPOSE_FILE) pull
	docker-compose -f $(COMPOSE_FILE) up --build -d

clean:
#ferma docker e servizie rimuove le immagini
	docker-compose -f $(COMPOSE_FILE) down
	docker image prune -a

vclean:
#rimuove volumi doker gli elenca e li rimuove e poi cancella i dati persistenti in wordpress e mariadb
	docker-compose -f $(COMPOSE_FILE) down --volumes
	rm -rf $(WORDPRESS_DATA_DIR)/*
	rm -rf $(MARIADB_DATA_DIR)/*