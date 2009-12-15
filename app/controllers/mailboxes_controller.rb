class MailboxesController < ApplicationController
  before_filter :require_user

  def show
    @mailbox = Mailbox.find(params[:id])
    if !current_user.mailboxes.include?(@mailbox)
      flash[:error] = 'You can only view your own mailboxes'
      redirect_to :root
    end
    render :partial => 'messages' if request.xhr?
  end
end
