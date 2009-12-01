class Wishlist < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :items
end
