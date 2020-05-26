#!/bin/bash

source './interactive/helpers.sh'

result=1
do_start

sign_up="$(make_valid_sign_up ausername apassword)"
if do_retry 5 do_2xx_request POST 'http://localhost:3000/v1/users' "$sign_up"; then
  if do_2xx_request POST 'http://localhost:3000/v1/sessions' "$sign_up"; then
    echo 'Successful sign-in'
    result=0
  else
    result=$?
    echo 'User failed sign-in!' >&2
  fi
fi

do_finish $result
