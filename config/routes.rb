Saaku20::Application.routes.draw do

  resources :press_releases do
    member do 
      get 'recent'
    end
  end

  namespace "admin" do
    resources :events, :users, :registrations, :broadcast_messages, :press_releases, :quick_links, :merchandises, :surveys, :alerts
  end
  
  #  resources :users do 
  #  member do 
  #    get 'change_password'
  #    post 'set_password'
  #  end
  #end

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
  resources :surveys 
  resources :surveyors 
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "sign_up" => "users#new", :as => "sign_up"
  match "/confirm/:id" => "registrations#confirm"
  match "/confirm_participation/:guid" => "events#confirm_participation"
  match "/registrants/:id" => "events#fetch_attendees"
  match "/artwork" => "merchandises#index"
  match "/press" => "press_releases#recent"
  match "/change_password" => "users#change_password"
  match "/set_password" => "users#set_password"
  match "/fight" => "home#fight"
  match "/voteright" => "home#voteright"
  match "/about_us" => "home#about"
  match "/surveys/:survey_id/participate" => "surveyors#new"
  match "/surveys/:id/results" => "surveys#results"
  match "/disp_alerts" => "home#alerts"
  get "users/destroy"
  resources :users
  resources :sessions
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

end

