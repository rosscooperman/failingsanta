class Notifier < ActionMailer::Base

  def signup(user)
    subject      'New account on failingsanta.com'
    recipients   user.email
    from         'system@failingsanta.com'
    sent_on      Time.now

    body         :user => user
  end

  def password_reset(user)
    subject      'Password reset request'
    recipients   user.email
    from         'system@failingsanta.com'
    sent_on      Time.now

    body         :user => user
  end

  def message(user)
    subject      'New message received on failingsanta.com'
    recipients   user.email
    from         'system@failingsanta.com'
    sent_on      Time.now

    body         :user => user
  end

  def item_removed(user, item)
    subject      'An item you purchased on failingsanta.com has been removed'
    recipients   user.email
    from         'system@failingsanta.com'
    sent_on      Time.now

    body         :user => user, :item => item
  end
end
