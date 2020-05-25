#!/bin/bash

# $1 type
# $2 url
do_request() {
  curl -o - -f -X "$1" "$2" 2>/dev/null
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

result=1
docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml up -d --force-recreate --remove-orphans

sign_up='{"username": "francesco", "password": "apassword", "password_confirmation": "apassword"}'
if do_retry 5 do_request POST 'http://localhost:3000/v1/users' "$sign_up"; then
  # sign in
  result=0
fi

docker-compose -f docker-compose.yml down

if [ $result -eq 0 ]; then
  echo "- - - Success - - -"
else
  echo "- - - Failure - - -"
fi
exit $result
