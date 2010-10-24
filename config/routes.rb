SoundcloudSocialDownload::Application.routes.draw do
  resources :users
  resource :session
  resources :posts
  match '/export' => 'users#index', :as => :export
  match '/activate' => 'sessions#new', :as => :activate, :service => 'soundcloud'
  match '/login/:service' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/download' => 'posts#download', :as => :download
  match '/oauth_callback/:service' => 'sessions#oauth_callback', :as => :oauth_callback
  match '/' => 'posts#new', :as => :root
  match '/:controller(/:action(/:id))'
end