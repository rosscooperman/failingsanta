class RecommendationsController < ApplicationController
  before_filter :require_user

  def new
    @recommendation = User.find(params[:user_id]).recommendations_for.build
    render :layout => false if request.xhr?
  end

  def create
    @recommendation = Recommendation.new(params[:recommendation])
    @recommendation.for = User.find(params[:user_id])
    @recommendation.by = current_user
    if @recommendation.save
      flash[:notice] = 'Recommendation created successfully'
      redirect_to :root
    else
      render :action => 'new'
    end
  end

  def edit
    can_edit(@recommendation = Recommendation.find(params[:id]))
  end

  def update
    return unless can_edit(@recommendation = Recommendation.find(params[:id]))

    if @recommendation.update_attributes(params[:recommendation])
      flash[:notice] = 'Recommendation updated successfully'
      redirect_to :root
    else
      render :action => 'edit'
    end
  end

  def buy
    current_user.recommendations_bought << Recommendation.find(params[:id])
    flash[:notice] = 'Recommendation marked as bought :)'
    redirect_to :back
  end

  def return
    current_user.recommendations_bought.delete(Recommendation.find(params[:id]))
    flash[:notice] = 'Recommendation marked as returned! :('
    redirect_to :back
  end

  private

  def can_edit(recommentation)
    if @recommendation.by != current_user
      flash[:error] = "You cannot edit a recommendation you didn't make"
      redirect_to :root
      false
    else
      true
    end
  end
end
