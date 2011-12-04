# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)     not null
#  login              :string(255)     not null
#  email              :string(255)     not null
#  crypted_password   :string(255)
#  password_salt      :string(255)
#  persistence_token  :string(255)     not null
#  login_count        :integer         default(0), not null
#  failed_login_count :integer         default(0), not null
#  last_request_at    :datetime
#  current_login_at   :datetime
#  last_login_at      :datetime
#  current_login_ip   :string(255)
#  last_login_ip      :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  admin              :boolean
#  perishable_token   :string(255)     default(""), not null
#  inbox_id           :integer
#  sent_id            :integer
#  archive_id         :integer
#

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
