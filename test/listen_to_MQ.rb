#!/usr/bin/env ruby
require 'bunny'

conn = Bunny.new(:hostname => 'localhost', :user => 'guest', :password => 'guest')
conn.start

ch = conn.create_channel
q = ch.queue("hello_q")
#ch.default_exchange.publish("Hello World!", :routing_key => q.name)

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
q.subscribe(:block => true) do |delivery_info, properties, body|
  puts " [x] Received #{body}"

  # cancel the consumer to exit
  #delivery_info.consumer.cancel
end
