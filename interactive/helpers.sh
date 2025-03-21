#!/bin/bash

# $1 type
# $2 url
# $3 body
do_2xx_request() {
  local body
  body="${@:3}"

  curl -o - -f -H "Content-Type: application/json" -X "$1" "$2" --data "$body"
  curl_result=$?
  test $curl_result -eq 0 && echo

  return $curl_result
}

# $1 type
# $2 url
# $3 body
do_request() {
  local body
  body="${@:3}"

  curl -o - -H "Content-Type: application/json" -X "$1" "$2" --data "$body"
  curl_result=$?
  test $curl_result -eq 0 && echo

  return $curl_result
}

# $1 times
# $2 command
# $n args
do_retry() {
  local args
  local cmd_result

  args="${@:3}"
  cmd_result=0

  for run in $(seq 0 $1); do
    ($2 $args)
    cmd_result=$?

    test $cmd_result -eq 0 && break

    sleep 1
  done

  return $cmd_result
}

do_start() {
  docker-compose -f docker-compose.yml build
  docker-compose -f docker-compose.yml up -d --force-recreate --remove-orphans
}

do_finish() {
  docker-compose -f docker-compose.yml down

  if [ $1 -eq 0 ]; then
    echo "- - - Success - - -"
  else
    echo "- - - Failure - - -"
  fi
  exit $1
}

# $1 username
# $2 password
# $3 password_confirmation
make_sign_up() {
  printf '{"name": "%s", "password": "%s", "password_confirmation": "%s"}' "$1" "$2" "$3"
}

# $1 username
# $2 password
make_valid_sign_up() {
  make_sign_up "$1" "$2" "$2"
}
