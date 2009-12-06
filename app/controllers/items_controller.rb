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
    if Item.find(params[:id]).destroy
      flash[:notice] = 'Item deleted successfully'
    else
      flash[:error] = 'Item could not be deleted'
    end
    redirect_to wishlists_path
  end

  def buy
    current_user.bought_items << Item.find(params[:id])
    flash[:notice] = 'Item marked as bought :)'
    redirect_to :back
  end

  def return
    current_user.bought_items.delete(Item.find(params[:id]))
    flash[:notice] = 'Item marked as returned! :('
    redirect_to :back
  end
end
