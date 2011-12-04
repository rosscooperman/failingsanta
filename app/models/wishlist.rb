# == Schema Information
#
# Table name: wishlists
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  name        :string(255)
#  item_count  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  items_count :integer         default(0)
#

class Wishlist < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :items
end
