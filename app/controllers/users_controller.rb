class UsersController < ApplicationController
  before_filter :require_admin, :only => [:index, :new, :create, :destroy]
  before_filter :require_user,  :only => [:show, :edit, :update]

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.randomize_password
    if @user.save
      @user.wishlists.create :name => 'Default Wishlist', :item_count => 0
      flash[:notice] = 'User created successfully'
      redirect_to @user
      @user.reset_perishable_token!
      AuthMailer.signup(@user).deliver
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User updated successfully'
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash[:notice] = (@user.destroy) ? 'User deleted successfully' : 'User could not be deleted'
    redirect_to :back
  end
end
