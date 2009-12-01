class User < ActiveRecord::Base
  has_many :wishlists

  acts_as_authentic do |config|
    config.ignore_blank_passwords = true
    config.perishable_token_valid_for = 1.month
  end
end
