class ItemsController < ApplicationController
  before_filter :require_user

  def new
    @item = Wishlist.find(params[:wishlist_id]).items.build
    render :layout => false if request.xhr?
  end

  def create
    wishlist = Wishlist.find(params[:wishlist_id])
    @item = wishlist.items.create(params[:item])
    if @item.valid?
      flash[:notice] = 'Item added successfully'
      redirect_to wishlists_path
    else
      render :action => 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item updated successfully'
      redirect_to wishlists_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if item = Item.find(params[:id]).destroy
      ItemMailer.item_removed(item.buyer, item).deliver if item.buyer
      flash[:notice] = 'Item deleted successfully'
    else
      flash[:error] = 'Item could not be deleted'
    end
    redirect_to wishlists_path
  end

  def buy
    item = Item.find(params[:id])
    current_user.bought_items << item
    flash[:notice] = 'Item marked as bought :)'
    redirect_to wishlist_path(item.wishlist)
  end

  def return
    item = Item.find(params[:id])
    current_user.bought_items.delete(item)
    flash[:notice] = 'Item marked as returned! :('
    redirect_to wishlist_path(item.wishlist)
  end
end
