class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_many :receipts
  has_many :recipients, :through => :receipts do
    def to_s
      names = find(:all, :select => 'name').map { |r| r.name }
      names.join ', '
    end
  end
  belongs_to :mailbox, :counter_cache => true

  def recipient_names
    User.find_all_by_login(to.split(',')).map{ |u| u.name }.join(', ')
  end

  def format_reply
    "<p></p><p>on #{created_at.to_s(:withtime)}, #{sender.name}" +
    " wrote:</p><blockquote>#{body}</blockquote>"
  end
end
