#!/bin/bash

source './interactive/helpers.sh'

result=1
do_start

sign_up="$(make_valid_sign_up ausername apassword)"
if do_retry 5 do_2xx_request POST 'http://localhost:3000/v1/users' "$sign_up"; then
  # do_request POST 'http://localhost:3000/v1/users' "$sign_up"
  result=$?
fi

do_finish $result
