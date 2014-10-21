CUR_DIR = $(shell pwd)

all: compile run

clean:
	docker rm mysql
	docker rm webapp

compile:
	docker build -t mysql $(CUR_DIR)/docker-mysql
	docker build -t webapp $(CUR_DIR)/docker-nginx-php

stop:
	docker stop mysql
	docker stop webapp

run:
	@( docker run -p 3306:3306 --name mysql -d mysql /sbin/my_init --enable-insecure-key )
	@( docker run -v $(ROOT):/var/www:rw -p 80:80 --name webapp --link mysql:db -d webapp /sbin/my_init --enable-insecure-key )

.PHONY: all compile stop run
