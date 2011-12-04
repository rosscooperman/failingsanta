class MessageMailer < ActionMailer::Base
  default from: 'system@failingsanta.com'

  def message(user)
    @user = user
    mail subject: 'New message received on failingsanta.com', to: user.email, sent_on: Time.now
  end
end
