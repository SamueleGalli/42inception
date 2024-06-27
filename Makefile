include srcs/.env
export

all: create_dirs
	@echo "Compiling..."
	docker-compose -f $(COMPOSE_FILE) pull
	docker-compose -f $(COMPOSE_FILE) up --build -d --remove-orphans

create_dirs:
	@echo "Creating directories for WORDPRESS and MARIADB persistences"
	mkdir -p ${WORDPRESS_DATA_DIR}
	mkdir -p ${MARIADB_DATA_DIR}

clean:
	@echo "shutting down dockers"
	docker-compose -f $(COMPOSE_FILE) down --remove-orphans
	docker image prune -a

fclean:
	@echo "cleaning all volumes and docker"
	docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	sudo rm -rf $(WORDPRESS_DATA_DIR)/*
	sudo rm -rf $(MARIADB_DATA_DIR)/*

re: fclean all
	@echo "cleaning and rebuilding"

restart: re
	clear && docker ps
