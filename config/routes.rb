ActionController::Routing::Routes.draw do |map|
  # resource routing
  map.resource  :auth, :controller => :auth, :only => [:new, :create, :edit, :update, :destroy]
  map.resources :users do |users|
    users.resources :recommendations, :only => [ :new, :create ]
  end
  map.resources :recommendations, :only => [ :edit, :update, :destroy ],
                                  :member => { :buy => :put, :return => :put }

  map.resources :wishlists, :only => [:index, :show] do |wishlist|
    wishlist.resources :items, :only => [:new, :create, :edit, :update, :destroy],
                               :member => { :buy => :put, :return => :put }
  end
  map.resources :messages, :member => { :reply => :get }
  map.resources :feedback, :only => [ :index, :new, :create ]

  # root, named, etc. routes
  map.login 'login', :controller => :auth, :action => 'new'
  map.logout 'logout', :controller => :auth, :action => 'destroy'
  map.root :controller => 'wishlists'
end
