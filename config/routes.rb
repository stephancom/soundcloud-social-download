SoundcloudSocialDownload::Application.routes.draw do
  resources :users, :only => [:index, :create]
  match '/export' => 'users#index', :as => :export

  resource :session, :only => [:new, :destroy]
  match '/activate' => 'sessions#new', :as => :activate, :service => 'soundcloud'
  match '/login/:service' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/oauth_callback/:service' => 'sessions#oauth_callback', :as => :oauth_callback

  resources :posts, :only => [:new, :create]
  match '/download' => 'posts#download', :as => :download
  match '/' => 'posts#new', :as => :root
end