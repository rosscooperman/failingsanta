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
