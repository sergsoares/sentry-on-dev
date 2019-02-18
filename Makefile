init:
	@bash init.bash

start:
	@docker-compose up -d

stop:
	@docker-compose stop

clean:
	@docker-compose down -v