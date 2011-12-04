# == Schema Information
#
# Table name: recommendations
#
#  id          :integer         not null, primary key
#  by_id       :integer
#  for_id      :integer
#  buyer_id    :integer
#  name        :string(255)
#  description :text
#  url         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Recommendation < ActiveRecord::Base
  belongs_to :by, :class_name => 'User'
  belongs_to :for, :class_name => 'User'
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
