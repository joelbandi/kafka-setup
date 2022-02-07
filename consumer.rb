require 'racecar'
require 'colorize'

Racecar.configure do |config|
  config.brokers = ['localhost:9092']
end

class MessageConsumer < Racecar::Consumer
  subscribes_to "messages-from-the-void"

  def process(message)
    puts "Message Received - #{message.value.green.bold}"
  end
end
