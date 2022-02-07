# Simple Dockerized development setup for kafka.

# Usage

First make sure you have Ruby and docker installed.

1. git clone this repo
2. `bundle install`
3. `docker-compose up -d`
4. start consumer with `bundle exec racecar --require consumer MessageConsumer`
5. start producer with `ruby producer.rb`
