require 'securerandom'
require 'waterdrop'
require 'colorize'

producer = WaterDrop::Producer.new do |config|
  config.deliver = true
  config.kafka = {
    'bootstrap.servers': 'localhost:9092',
    'request.required.acks': 1
  }
end

producer.monitor.subscribe('message.produced_sync') do |event|
  puts "#{event[:message][:payload].to_s.green.bold} was produced to '#{event[:message][:topic].to_s.blue.bold}' topic!"
end

begin
  loop do
    producer.produce_sync(
      topic: 'messages-from-the-void',
      payload: SecureRandom.alphanumeric(6)
    )
    sleep SecureRandom.random_number(5)
  end
rescue Interrupt
  puts "Producer is shut down."
  producer.close
rescue StandardError => e
  puts "Producer is shut down."
  producer.close
  raise e
end
