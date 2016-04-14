require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'goodfoodhunting',
  username: 'isha'
}

ActiveRecord::Base.establish_connection(options)
