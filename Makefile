up:
	docker-compose -f srcs/docker-compose.yml up -d
down:
	docker-compose -f srcs/docker-compose.yml down
stop:
	docker-compose -f srcs/docker-compose.yml stop
log:
	docker-compose -f srcs/docker-compose.yml logs
build:
	docker-compose -f srcs/docker-compose.yml build
.PHONY: up down restart log build
