Saaku20::Application.routes.draw do

  resources :registrations

  resources :localities

  resources :wards

  resources :events do
    member do
      get 'attend'
      get 'volunteer'
      get 'invite'
      post 'register'
    end
  end


  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  get "sign_up" => "users#new", :as => "sign_up"
  match "/confirm/:id" => "registrations#confirm"
  match "/confirm_participation/:guid" => "events#confirm_participation"

  get "users/destroy"

  resources :users
  resources :sessions

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

end
