class Item < ActiveRecord::Base
  belongs_to :wishlist, :counter_cache => true
  belongs_to :buyer, :class_name => 'User'

  def url=(val)
    if val.blank?
      self[:url] = val
    else
      self[:url] = (val.match /^\w*\:\/\//) ? val : "http://#{val}"
    end
  end
end
