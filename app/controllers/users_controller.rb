class UsersController < ApplicationController
  before_filter :require_admin,   :only => [:index, :new, :create, :destroy]
  # before_filter :require_current, :only => [:show, :edit, :update]

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end
end
