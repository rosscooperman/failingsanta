begin
  if User.find(:all).count <= 0
    admin = User.new(
      :name => 'Admin',
      :email => 'nobody@nowhere.com',
      :login => 'admin',
      :admin => true
    )
    puts "Created admin user: admin/#{admin.randomize_password}"
    admin.save
  end
rescue
  puts "Not able to check for default user"
end