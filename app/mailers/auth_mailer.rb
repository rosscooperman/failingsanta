class AuthMailer < ActionMailer::Base
  default from: 'system@failingsanta.com'

  def signup(user)
    @user = user
    mail subject: 'New account on failingsanta.com', to: user.email
  end

  def password_reset(user)
    @user = user
    mail subject: 'Password reset request', to: user.email
  end
end
