Failingsanta::Application.routes.draw do
  resource  :auth, controller: 'auth', except: [:index, :show] do
    member do
      get :reset
      put :doreset
    end
  end

  resources :users do |users|
    resources :recommendations, :only => [ :new, :create ]
  end

  resources :recommendations, only: [ :edit, :update, :destroy ] do
    put :buy, :return, :on => :member
  end

  resources :wishlists, :only => [:index, :show] do
    resources :items, :except => [:show, :index] do
      put :buy, :return, :on => :member
    end
  end

  resources :mailboxes, :only => [ :show ]
  resources :feedback,  :only => [ :index, :new, :create ]
  resources :messages,  :except => [:index] do
    get :reply, :on => :member
  end

  match "/login"  => "auth#new",     :as => "login"
  match "/logout" => "auth#destroy", :as => "logout"
  root :to => "wishlists#index"
end
