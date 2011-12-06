class ItemMailer < ActionMailer::Base
  default from: 'system@failingsanta.com'

  def item_removed(user, item)
    @user = user
    @item = item
    mail subject: 'An item you purchased on failingsanta.com has been removed', to: user.email
  end
end
