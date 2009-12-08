class WishlistsController < ApplicationController
  before_filter :require_user

  def index
    @wishlist = current_user.wishlists.first
    @users = User.find(:all, :conditions => "users.id <> #{current_user.id}",
                       :joins => [:wishlists], :order => 'name ASC')
    @user = (params[:id]) ? User.find(params[:id]) : @users.first
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
