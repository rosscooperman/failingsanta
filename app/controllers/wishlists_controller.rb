class WishlistsController < ApplicationController
  before_filter :require_user, :load_data

  def index
  end

  def show
    if request.xhr?
      render :partial => 'wishlist', :layout => false
    else
      render :action => 'index'
    end
  end

private

  def load_data
    @wishlist = current_user.wishlists.first
    @wishlist = current_user.wishlists.create(name: 'Default Wishlist', item_count: 0) if @wishlist.nil?

    @users = User.where("users.id <> ?", current_user.id).joins(:wishlists).order('name ASC')
    @user  = params[:id].blank? ? @users.first : User.find(params[:id])
  end
end
