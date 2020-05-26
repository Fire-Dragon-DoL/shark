#!/bin/bash

docker-compose -f docker-compose.development.yml build
docker-compose -f docker-compose.development.yml up -d --force-recreate --remove-orphans db
REDIS_URL="redis://localhost:6400/15" bundle exec rails test
result=$?
docker-compose -f docker-compose.development.yml down
exit $result
