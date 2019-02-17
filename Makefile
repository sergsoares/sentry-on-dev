init: upgrade start message

generate-random-secret-key:
	@sed -i "$ s/$/$(docker-compose run --rm sentry sentry config generate-secret-key)/" sentry.env

upgrade:
	@(docker-compose run --rm sentry sentry upgrade --noinput)

create-admin-user:
	@(docker-compose exec sentry sentry createuser --email admin@admin.com --password admin --superuser --no-input)

start:
	@docker-compose up -d

message:
	@(sleep 20; open "http://localhost:7000/sentry/")

stop:
	@docker-compose stop

clean:
	@docker-compose down -v