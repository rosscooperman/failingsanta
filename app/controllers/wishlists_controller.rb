class WishlistsController < ApplicationController
  before_filter :require_user

  def index
    @wishlist = current_user.wishlists.first
    @wishlists = Wishlist.find(:all, :conditions => "id <> #{@wishlist.id}")
  end
end
