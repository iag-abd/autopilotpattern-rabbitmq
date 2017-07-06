#!/usr/bin/env ruby
require 'bunny'

conn = Bunny.new(:hostname => 'localhost', :user => 'guest', :password => 'guest')
conn.start

ch = conn.create_channel
q = ch.queue("hello_q")
ch.default_exchange.publish("Hello World!", :routing_key => q.name)
