class Mailbox < ActiveRecord::Base
  belongs_to :user
  has_many   :messages, :dependent => :destroy, :order => 'created_at DESC'
end
