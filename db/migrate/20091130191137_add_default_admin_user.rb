class AddDefaultAdminUser < ActiveRecord::Migration
  def self.up
    admin = User.new(
      :name => 'Admin',
      :email => 'nobody@nowhere.com',
      :login => 'admin',
      :admin => true
    )
    puts "New admin password: #{admin.randomize_password}"
    admin.save
  end

  def self.down
    User.find_by_login('admin').destroy
  end
end
