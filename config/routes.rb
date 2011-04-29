Saaku20::Application.routes.draw do

  resources :merchandises

  resources :quick_links
  resources :invites
  resources :registrations
  resources :localities
  resources :wards
  resources :events do
    resources :merchandises
    member do
      get 'attend'
      get 'attendees'
      get 'volunteer'
      get 'invite'
      get 'fetch_attendees'
      post 'register'
      post 'send_invite'
    end
  end


  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "sign_up" => "users#new", :as => "sign_up"
  match "/confirm/:id" => "registrations#confirm"
  match "/confirm_participation/:guid" => "events#confirm_participation"
  match "/registrants/:id" => "events#fetch_attendees"
  match "/artwork" => "merchandises#index"
  get "users/destroy"
  resources :users
  resources :sessions
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

end
