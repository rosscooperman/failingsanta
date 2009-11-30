class AddDefaultAdminUser < ActiveRecord::Migration
  def self.up
    User.create(
      :name => 'Admin',
      :email => 'nobody@nowhere.com',
      :login => 'admin',
      :password => 'flB8xtvAHpB5Qm12QQTMHx',
      :password_confirmation => 'flB8xtvAHpB5Qm12QQTMHx',
      :admin => true
    )
  end

  def self.down
    User.find_by_login('admin').destroy
  end
end
