class ItemsController < ApplicationController

  def new
    @item = Wishlist.find(params[:wishlist_id]).items.build
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
end
