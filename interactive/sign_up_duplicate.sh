#!/bin/bash

source './interactive/helpers.sh'

result=1
do_start

sign_up="$(make_valid_sign_up ausername apassword)"
echo "Sign up with:"
echo "$sign_up"

if do_retry 5 do_2xx_request POST 'http://localhost:3000/v1/users' "$sign_up"; then
  echo 'User signed up'
  if do_2xx_request POST 'http://localhost:3000/v1/users' "$sign_up"; then
    result=2
    echo 'User signed up twice!' >&2
  else
    result=0
    echo 'User prevented from signing up again'
  fi
fi

do_finish $result
