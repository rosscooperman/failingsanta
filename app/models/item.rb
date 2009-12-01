class Item < ActiveRecord::Base
  belongs_to :wishlist, :counter_cache => true
end
