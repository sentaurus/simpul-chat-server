# config/initializers/pusher.rb

require 'pusher'

Pusher.app_id = '1811451'
Pusher.key = '52230eba9e5e9ec46b5c'
Pusher.secret = 'a7fe8fb7bc06d4a977c5'
Pusher.cluster = 'ap1'
Pusher.logger = Rails.logger
Pusher.encrypted = true
