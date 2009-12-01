class AllUsersHaveDefaultWishlist < ActiveRecord::Migration
  def self.up
    User.find(:all, :include => [:wishlists]).each do |user|
      if user.wishlists.count <= 0
        user.wishlists.create :name => 'Default Wishlist', :item_count => 0
      end
    end
  end

  def self.down
  end
end
