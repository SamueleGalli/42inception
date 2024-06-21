COMPOSE_FILE=srcs/docker-compose.yml
WORDPRESS_DATA_DIR=/home/sgalli/data/wordpres_data
MARIADB_DATA_DIR=/home/sgalli/data/mariadb_data
all:
	docker-compose -f $(COMPOSE_FILE) pull
	docker-compose -f $(COMPOSE_FILE) up --build -d --remove-orphans

clean:
	docker-compose -f $(COMPOSE_FILE) down --remove-orphans
	docker image prune -a

fclean:
	docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	sudo rm -rf $(WORDPRESS_DATA_DIR)/*
	sudo rm -rf $(MARIADB_DATA_DIR)/*

re:
	docker-compose -f $(COMPOSE_FILE) down --volumes
	sudo rm -rf $(WORDPRESS_DATA_DIR)/*
	sudo rm -rf $(MARIADB_DATA_DIR)/*
	docker-compose -f $(COMPOSE_FILE) pull
	docker-compose -f $(COMPOSE_FILE) up --build -d --remove-orphans
	clear && docker ps
