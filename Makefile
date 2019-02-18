

initializing: upgrade start create-admin-user wait-sentry-initializing get-sentry-dsn message

upgrade:
	@(docker-compose run --rm sentry sentry upgrade --noinput)

start:
	@docker-compose up -d

create-admin-user:
	@(docker-compose exec sentry sentry createuser --email admin --password admin --superuser --no-input)

wait-sentry-initializing:
	@sleep 90

get-sentry-dsn:
	@(docker run --rm -it -v "$(PWD)":/src --network=sentryonpremise_default buildkite/puppeteer bash -c "cd src; node get_dsn.js")

message:
	@sleep 1
	@echo  "User: admin"
	@echo  "Password: admin"
	@echo
	@echo "Login and create a new token"
	@echo "http://localhost:7000/api/new-token/"

stop:
	@docker-compose stop

clean:
	@docker-compose down -v

generate-random-secret-key:
	@sed -i "$ s/$/$(docker-compose run --rm sentry sentry config generate-secret-key)/" sentry.env

sentry:
	@(docker-compose exec sentry sentry createuser --help)

sentry-config:
	@(docker-compose exec sentry sentry config --help)

sentry-init:
	@(docker-compose exec sentry bash -c "cat ~/.sentry")
