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

    @users = if current_user.giftee.nil?
      User.where("users.id <> ?", current_user.id).joins(:wishlists).order('name ASC')
    else
      User.where("users.giftee_id IS NULL OR users.id = ?", current_user.giftee_id).joins(:wishlists).order('name ASC')
    end

    @user = params[:id].blank? ? @users.first : User.find(params[:id])
    @user = @users.first unless @users.include?(@user)
  end
end
