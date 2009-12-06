class Item < ActiveRecord::Base
  belongs_to :wishlist, :counter_cache => true
  belongs_to :buyer, :class_name => 'User'

  def url=(val)
    self[:url] = (val.match /^\w*\:\/\//) ? val : "http://#{val}" unless val.blank?
  end
end
