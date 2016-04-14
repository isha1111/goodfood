
class Dish < ActiveRecord::Base
  belongs_to :dish_type
  has_many :comments
end
