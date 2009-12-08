class FeedbackController < ApplicationController
  before_filter :require_admin, :only => [:index]
  before_filter :require_user,  :only => [:new, :create]

  def index
    @feedback = Feedback.all(:order => 'id ASC')
  end

  def new
    @feedback = Feedback.new
    render :layout => false if request.xhr?
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.user = current_user
    if @feedback.save
      flash[:notice] = "Thanks for your feedback!"
      redirect_to :root
    else
      render :action => 'new'
    end
  end
end
