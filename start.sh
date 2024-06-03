#!/usr/bin/expect -f
bundle exec puma -C config/puma.rb

ngrok http http://localhost:3000