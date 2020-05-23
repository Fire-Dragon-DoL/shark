#!/bin/bash

set -e

echo "RAILS_ENV set to $RAILS_ENV"
cmd="bundle install --jobs=4"
if [ 'production' == "$RAILS_ENV" ]; then
  cmd="$cmd --without=development,test"
fi

echo "$cmd"
($cmd)

echo '- - -'
echo '(done)'
echo
