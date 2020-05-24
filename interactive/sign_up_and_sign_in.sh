#!/bin/bash

# $1 type
# $2 url
do_request() {
  curl -o - -f -X "$1" "$2" 2>/dev/null
  curl_result=$?
  if [ "$curl_result" -eq 0 ]; then
    echo
  fi

  return $curl_result
}

# $1 times
# $2 command
# $n args
do_retry() {
  local args="${@:3}"
  for run in {1..$1}; do
    ($2 $args)
    if [ "$?" -eq 0 ]; then
      break
    else
      sleep 1
    fi
  done
}

result=1
docker-compose build
docker-compose up -d --force-recreate --remove-orphans

if do_retry 4 do_request POST 'http://localhost:3000/v1/users'; then
  # sign in
  result=0
fi

docker-compose down

if [ "$result" -eq 0 ]; then
  echo "- - - Success - - -"
else
  echo "- - - Failure - - -"
fi
