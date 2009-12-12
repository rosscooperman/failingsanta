class MessagesController < ApplicationController
  before_filter :require_user

  def index
    if params[:sent]
      @messages = current_user.sent_messages
    else
      @messages = current_user.messages
    end
  end

  def show
    @message = Message.find(params[:id], :joins => [:sender, :recipients])
    unless @message.sender == current_user || @message.recipients.include?(current_user)
      flash[:error] = 'You can only view messages that were sent to you!'
      redirect_to messages_path
    end
  end

  def new
    @message = Message.new
    @recipients = User.find(:all, :conditions => "id <> #{current_user.id}")
  end

  def reply
    original = Message.find(params[:id], :joins => [:sender, :recipients])
    subject = ((original.subject.match /^\s*re\:?\s*/i) ? '' : 'Re: ') + original.subject
    @message = Message.new(:subject => subject, :body => original.format_reply)
    @message.recipients << original.sender
    if params[:all]
      original.recipients.each { |r| @message.recipients << r unless r == current_user }
    end
    @recipients = User.find(:all, :conditions => "id <> #{current_user.id}")
    render :action => 'new'
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

  def destroy
    receipt = current_user.receipts.find_by_message_id(params[:id])
    # @message = Message.find(params[:id], :joins => [:recipients])
    if receipt && receipt.update_attribute(:deleted, true)
      flash[:notice] = 'Message deleted successfully'
    else
      flash[:error] = 'You can only delete messages that were sent to you!'
    end
    redirect_to messages_path
  end
end
