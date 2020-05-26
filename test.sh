#!/bin/bash

docker-compose -f docker-compose.development.yml build
docker-compose -f docker-compose.development.yml up -d --force-recreate --remove-orphans
bundle exec rails test
result=$?
docker-compose -f docker-compose.development.yml down
exit $result
