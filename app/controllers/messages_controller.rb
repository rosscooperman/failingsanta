class MessagesController < ApplicationController
  before_filter :require_user

  def index
    @messages = current_user.messages
  end

  def show
    @message = Message.find(params[:id], :include => [:sender, :recipients])
    unless @message.recipients.include?(current_user)
      flash[:error] = 'You can only view messages that were sent to you!'
      redirect_to messages_path
    end
  end

  def new
    @message = Message.new
    @recipients = User.find(:all, :conditions => "id <> #{current_user.id}")
  end

  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    if @message.save
      @message.recipients.each { |r| Notifier.deliver_message(r) }
      flash[:notice] = 'Message successfully sent'
      redirect_to messages_path
    else
      render :action => 'new'
    end
  end
end
