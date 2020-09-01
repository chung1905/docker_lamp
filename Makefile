up:
	UUID=$(shell id -u) docker-compose up -d --no-recreate

stop:
	docker-compose stop
