class MessagesController < ApplicationController
  before_filter :require_user

  def show
    @message = Message.find(params[:id])
    unless @message.mailbox.user == current_user
      flash[:error] = 'You can only view messages that were sent to you!'
      redirect_to mailbox_path(current_user.inbox)
    end
    @message.update_attribute(:new, false)
  end

  def new
    @message = Message.new
  end

  def reply
    # set up the new message with correct subject/body
    original = Message.find(params[:id], :joins => [:sender])
    subject = ((original.subject.match /^\s*re\:?\s*/i) ? '' : 'Re: ') + original.subject
    @message = Message.new(:subject => subject, :body => original.format_reply)

    # build the "automatic" recipients array
    @recipients  = [original.sender]
    @recipients += User.find_all_by_login(original.to.split(',')) if params[:all]
    @recipients.delete(current_user)
    @recipients.uniq!

    # render!
    render :action => 'new'
  end

  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.mailbox = current_user.sent

    if params[:recipient_ids]
      recipients = User.find(params[:recipient_ids])
      @message.to = recipients.map{ |r| r.login }.join(',')
      if @message.save
        recipients.each do |r|
          newmsg = @message.clone
          newmsg.new = true
          newmsg.update_attributes(:mailbox => r.inbox)
          MessageMailer.send_message(r).deliver
        end
        flash[:notice] = 'Message successfully sent'
        redirect_to mailbox_path(current_user.inbox) and return
      end
    else
      @message.errors.add(:base, 'You must select at least one recipient')
    end
    render :new
  end

  def destroy
    message = Message.find(params[:id], :joins => [:mailbox])
    if message.mailbox.user != current_user
      flash[:error] = 'You can only delete messages that were sent to you!'
    elsif message.destroy
      flash[:notice] = 'Message deleted successfully'
    else
      flash[:error] = 'Unable to delete selected message'
    end
    redirect_to mailbox_path(current_user.inbox)
  end
end
