class MessageMailer < ActionMailer::Base
  default from: 'system@failingsanta.com'

  def send_message(user)
    @user = user
    mail subject: 'New message received on failingsanta.com', to: user.email
  end
end
