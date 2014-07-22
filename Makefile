CUR_DIR = $(shell pwd)

all: compile run

stop:
	docker stop mysql
	docker rm mysql
	docker stop webapp
	docker rm webapp

compile:
	docker build -t mysql $(CUR_DIR)/docker-mysql
	docker build -t webapp $(CUR_DIR)/docker-nginx-php

run:
	@( docker run -p 3306:3306 --name mysql -d mysql /sbin/my_init --enable-insecure-key )
	@( docker run -v $(CUR_DIR)/www:/var/www:rw -p 80:80 --name webapp -d webapp /sbin/my_init --enable-insecure-key )

.PHONY: all compile stop run
