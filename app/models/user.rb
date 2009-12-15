class User < ActiveRecord::Base
  has_many :wishlists
  has_many :bought_items, :class_name => 'Item', :foreign_key => :buyer_id

  has_many :mailboxes
  belongs_to :inbox, :class_name => 'Mailbox'
  belongs_to :sent, :class_name => 'Mailbox'
  belongs_to :archive, :class_name => 'Mailbox'

  has_many :feedback
  has_many :recommendations, :foreign_key => :by_id
  has_many :recommendations_for, :class_name => 'Recommendation', :foreign_key => :for_id
  has_many :recommendations_bought, :class_name => 'Recommendation', :foreign_key => :buyer_id

  after_create :create_mailboxes

  acts_as_authentic do |config|
    config.ignore_blank_passwords = true
    config.perishable_token_valid_for = 2.weeks
    config.disable_perishable_token_maintenance = true
  end

  private

  def create_mailboxes
    self.inbox = mailboxes.create(:name => 'inbox')
    self.sent = mailboxes.create(:name => 'sent')
    self.archive = mailboxes.create(:name => 'archive')
    self.save
  end
end
