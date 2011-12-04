# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  wishlist_id :integer
#  name        :string(255)
#  description :text(255)
#  url         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  buyer_id    :integer
#

class Item < ActiveRecord::Base
  belongs_to :wishlist, :counter_cache => true
  belongs_to :buyer, :class_name => 'User'
  
  validates_length_of :description, :maximum => 500

  def url=(val)
    if val.blank?
      self[:url] = val
    else
      self[:url] = (val.match /^\w*\:\/\//) ? val : "http://#{val}"
    end
  end
end
