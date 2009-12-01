class Item < ActiveRecord::Base
  belongs_to :wishlist, :counter_cache => true
  belongs_to :buyer, :class_name => 'User'
end
