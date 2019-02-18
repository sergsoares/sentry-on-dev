#!/usr/bin/env bash

echo "\n Creating local sentry.env"
cp ./sentry.env.example ./sentry.env

echo "\n Running Migrations to Sentry Database"
docker-compose run --rm sentry sentry upgrade --noinput

echo "\n Starting Sentry Services"
make start

sleep 3

echo "\n Creating admin user to Sentry"
docker-compose exec sentry sentry createuser --email admin --password admin --superuser --no-input

sleep 90

echo "\n Waiting getting Sentry DSN"
docker run --rm -it -v "$(PWD)":/src --network=sentryonpremise_default buildkite/puppeteer bash -c "cd src; node get_dsn.js"

#docker run --rm -e "SENTRY_DSN=http://2f078df187a84ff7b9a168bc116985b1@sentry:9000/1" --network=sentryonpremise_default getsentry/sentry-cli send-event -m "Hello Sentry-dev Working"

