#!/bin/bash

source "$HOME/.rvm/scripts/rvm"
case $1 in
*)
  rvm ree-1.8.7-2011.03@dashboard-client
  bundle install --binstubs
  bundle exec rake test
esac
