class Notifier < ActionMailer::Base

  def signup(user, sent_at = Time.now)
    subject      'New account on failingsanta.com'
    recipients   user.email
    from         'system@failingsanta.com'
    sent_on      sent_at

    body       :user => user
  end

  def password_reset(user, sent_at = Time.now)
    subject      'Password reset request'
    recipients   user.email
    from         'system@failingsanta.com'
    sent_on      sent_at

    body       :user => user
  end

  def message(user, sent_at = Time.now)
    subject      'New message received on failingsanta.com'
    recipients   user.email
    from         'system@failingsanta.com'
    sent_on      sent_at

    body       :user => user
  end
end
