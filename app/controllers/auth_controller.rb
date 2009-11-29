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

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :root
  end
end
