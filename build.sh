#!/bin/bash

source "$HOME/.rvm/scripts/rvm"
case $1 in
*)
  rvm ree@dashboard-client
  bundle install --binstubs
  bundle exec rake test
esac
