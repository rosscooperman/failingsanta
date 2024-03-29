class AuthController < ApplicationController
  before_filter :require_user, :only => [:destroy]

  def new
    @session = UserSession.new
  end

  def create
    @session = UserSession.new(params[:user_session])
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
    redirect_to :login
  end

  def reset
    @user = User.new
  end

  def doreset
    user = User.find_by_email(params[:user][:email])
    if user
      user.reset_perishable_token!
      AuthMailer.password_reset(user).deliver
      flash[:notice] = 'Username and password sent!'
      redirect_to :login
    else
      flash[:error] = 'No user exists with that email address'
      @user = User.new
      render :action => 'reset'
    end
  end
end
