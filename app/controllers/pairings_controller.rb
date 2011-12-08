class PairingsController < ApplicationController

  def index
    @users = User.all
  end

  def create
    unless params[:pairings].blank?
      params[:pairings].each do |i, pairing|
        unless pairing[:user_id].blank?
          user = User.find(pairing[:user_id])
          user.giftee_id = (pairing[:giftee_id].blank?) ? nil : pairing[:giftee_id]
          user.save
        end
      end
      flash[:notice] = 'Pairings saved successfully'
    else
      flash[:error] = 'Invalid pairings form submission'
    end

    redirect_to pairings_url
  end
end
