require 'pry'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR)

require './db_config'
require './model/dish'
require './model/dish_type'
require './model/comment'
binding.pry
