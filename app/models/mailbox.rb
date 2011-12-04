# == Schema Information
#
# Table name: mailboxes
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  name           :string(255)
#  messages_count :integer         default(0)
#  created_at     :datetime
#  updated_at     :datetime
#

class Mailbox < ActiveRecord::Base
  belongs_to :user
  has_many   :messages, :dependent => :destroy, :order => 'created_at DESC'
end
