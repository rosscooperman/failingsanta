class AuthController < ApplicationController
  before_filter :require_user, :only => [:destroy]

  def new
    @session = UserSession.new
  end

  def create
    @session = UserSession.new(params[:session])
    if @session.save
      flash[:notice] = 'Login successful!'
      redirect_back_or_default :root
    else
      flash[:error] = 'Invalid username or password'
      render :action => 'new'
    end
  end

  def edit
    unless params[:token] && @user = User.find_using_perishable_token(params[:token])
      flash[:error] = "Password change requires a valid token"
      redirect_to :root
    end
  end

  def update
    if params[:token] && @user = User.find_using_perishable_token(params[:token])
      @user.update_attributes(params[:user])
      if @user.save
        flash[:notice] = "Password changed successfully"
        redirect_to :root
      else
        render :action => 'edit'
      end
    else
      flash[:error] = "Password change requires a valid token"
      redirect_to :root
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :root
  end
end
