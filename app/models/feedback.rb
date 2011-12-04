# == Schema Information
#
# Table name: feedback
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#

class Feedback < ActiveRecord::Base
  belongs_to :user
end
