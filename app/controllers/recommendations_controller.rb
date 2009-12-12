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

  def destroy
    return unless can_edit(recommendation = Recommendation.find(params[:id]))

    if recommendation.destroy
      flash[:notice] = 'Recommendation deleted successfully'
    else
      flash[:error] = 'Recommendation could not be deleted'
    end
    redirect_to :root
  end

  def buy
    recommendation = Recommendation.find(params[:id])
    current_user.recommendations_bought << recommendation
    flash[:notice] = 'Recommendation marked as bought :)'
    redirect_to wishlist_path(recommendation.for.wishlists.first)
  end

  def return
    recommendation = Recommendation.find(params[:id])
    current_user.recommendations_bought.delete(recommendation)
    flash[:notice] = 'Recommendation marked as returned! :('
    redirect_to wishlist_path(recommendation.for.wishlists.first)
  end

  private

  def can_edit(recommendation)
    if recommendation.by != current_user
      flash[:error] = "You cannot edit a recommendation you didn't make"
      redirect_to :root
      false
    else
      true
    end
  end
end
