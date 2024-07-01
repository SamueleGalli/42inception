include srcs/.env

all: create_dirs
	@echo "Compiling..."
	docker-compose -f ./srcs/docker-compose.yml pull
	docker-compose -f ./srcs/docker-compose.yml up --build -d --remove-orphans

create_dirs:
	@echo "Creating directories for WORDPRESS and MARIADB persistences"
	mkdir -p ${WORDPRESS_DATA_DIR}
	mkdir -p ${MARIADB_DATA_DIR}

clean:
	@echo "Shutting down Docker containers"
	docker-compose -f ./srcs/docker-compose.yml down --remove-orphans
	docker image prune -a

fclean:
	@echo "Cleaning all volumes and Docker containers"
	docker-compose -f ./srcs/docker-compose.yml down --volumes --remove-orphans
	sudo rm -rf $(WORDPRESS_DATA_DIR)/*
	sudo rm -rf $(MARIADB_DATA_DIR)/*

re: fclean all
	@echo "Cleaning and rebuilding"

restart: re
	clear && docker ps
