class WishlistsController < ApplicationController
  before_filter :require_user

  def index
    @wishlist = current_user.wishlists.first
    @wishlist = current_user.wishlists.create(name: 'Default Wishlist', item_count: 0) if @wishlist.nil?

    @users = User.where("users.id <> ?", current_user.id).joins(:wishlists).order('name ASC')
    @user  = (params[:id]) ? User.first(params[:id]) : @users.first
  end

  def show
    index
    if request.xhr?
      render :partial => 'wishlist', :layout => false
    else
      render :action => 'index'
    end
  end
end
