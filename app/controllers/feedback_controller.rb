class FeedbackController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.create(params[:feedback])
    if @feedback.valid?
      flash[:notice] = "Thanks for your feedback!"
      redirect_to :root
    else
      render :action => 'new'
    end
  end
end
