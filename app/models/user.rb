class User < ActiveRecord::Base
  has_many :wishlists
  has_many :bought_items, :class_name => 'Item', :foreign_key => :buyer_id
  has_many :receipts, :foreign_key => :recipient_id
  has_many :messages, :through => :receipts
  has_many :feedback

  acts_as_authentic do |config|
    config.ignore_blank_passwords = true
    config.perishable_token_valid_for = 1.month
  end
end
