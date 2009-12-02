ActionController::Routing::Routes.draw do |map|
  # resource routing
  map.resource  :auth, :controller => :auth, :only => [:new, :create, :edit, :update, :destroy]
  map.resources :users
  map.resources :wishlists, :only => [:index, :show] do |wishlist|
    wishlist.resources :items, :only => [:new, :create, :edit, :update, :destroy],
                       :member => { :buy => :put, :return => :put }
  end
  map.resources :messages, :member => { :reply => :get }

  # root, named, etc. routes
  map.login 'login', :controller => :auth, :action => 'new'
  map.logout 'logout', :controller => :auth, :action => 'destroy'
  map.root :controller => 'wishlists'
end
