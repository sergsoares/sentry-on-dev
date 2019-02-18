#!/usr/bin/env bash

source .env

echo "\n Creating local sentry.env"
cp ./sentry.env.example ./sentry.env

echo "\n Running Migrations to Sentry Database"
docker-compose run --rm sentry sentry upgrade --noinput

echo "\n Starting Sentry Services"
make start

sleep 60

echo "\n Creating admin user to Sentry"
docker-compose exec sentry sentry createuser --email admin --password admin --superuser --no-input

sleep 90

echo "\n Waiting getting Sentry DSN"
DSN=$(docker run --rm -it -v "$(PWD)":/src --network=sentryonpremise_default buildkite/puppeteer bash -c "cd src; node get_dsn.js");

FULL_DSN=$(docker run --rm -e DSN="${DSN}" frolvlad/alpine-bash bash -c 'echo "http"$DSN | sed "s/localhost:7000/sentry:9000/"')

WELCOME=$(echo "Hello $(whoami) start logging.")

docker run --rm -e SENTRY_DSN="${FULL_DSN}" --network=sentryonpremise_default getsentry/sentry-cli send-event -m "${WELCOME}"

echo ""
echo 'This is your Internal Sentry DSN (Development Purpose): '
echo "${FULL_DSN}"
echo ""
echo 'To use in laravel for example, put in your .env'
echo 'SENTRY_DSN='"${FULL_DSN}"
echo ""
echo 'To access your events'
echo "http://${SENTRY_DOCKER_HORT}:${SENTRY_DOCKER_PORT}/sentry/internal/"