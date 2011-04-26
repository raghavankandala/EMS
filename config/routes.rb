Saaku20::Application.routes.draw do

  resources :events

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  get "sign_up" => "users#new", :as => "sign_up"

  get "users/destroy"

  resources :users
  resources :sessions

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

end
