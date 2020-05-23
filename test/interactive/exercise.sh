#!/bin/bash

do_request() {
  curl -o - -f -X "$1" "$2" 2>/dev/null
  curl_result=$?
  if [ "$curl_result" -eq 0 ]; then
    echo
  fi

  return $curl_result
}

exercise() {
  do_request POST 'http://localhost:3000/v1/users'
}

docker-compose build
docker-compose up -d --force-recreate --remove-orphans
for run in {1..5}; do
  if exercise; then
    break
  else
    sleep 1
  fi
done
result=$?
docker-compose down

if [ "$result" -eq 0 ]; then
  echo "- - - Success - - -"
else
  echo "- - - Failure - - -"
fi
