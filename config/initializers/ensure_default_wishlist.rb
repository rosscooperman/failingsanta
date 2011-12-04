begin
  User.find(:all, :joins => [:wishlists]).each do |user|
    if user.wishlists.count <= 0
      user.wishlists.create :name => 'Default Wishlist', :item_count => 0
    end
  end
rescue
  puts "Not able to check/create default wishlists"
end