ActionController::Routing::Routes.draw do |map|
  # resource routing
  map.resources :users
  map.resource  :auth, :controller => :auth, :only => [:new, :create, :destroy]

  # root, named, etc. routes
  map.login 'login', :controller => :auth, :action => 'new'
  map.logout 'logout', :controller => :auth, :action => 'destroy'
  map.root :controller => 'users'
end
