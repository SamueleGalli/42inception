include srcs/.env

GREEN := \033[0;32m
RED := \033[0;31m
NC := \033[0m

all: create_dirs
	@echo "$(GREEN)Compiling...$(NC)"
	docker-compose -f ./srcs/docker-compose.yml pull
	docker-compose -f ./srcs/docker-compose.yml up --build -d --remove-orphans
	@echo "$(GREEN)Building completed$(NC)"

create_dirs:
	@echo "$(GREEN)Creating directories for WORDPRESS and MARIADB persistences$(NC)"
	mkdir -p ${WORDPRESS_DATA_DIR}
	mkdir -p ${MARIADB_DATA_DIR}

clean:
	@echo "$(RED)Shutting down Docker containers$(NC)"
	docker-compose -f ./srcs/docker-compose.yml down --remove-orphans
restart: clean all
