#!/bin/bash

source './interactive/helpers.sh'

do_start

sign_up="$(make_valid_sign_up '' 'apassword')"
do_retry 5 do_request POST 'http://localhost:3000/v1/users' "$sign_up"

do_finish $?
