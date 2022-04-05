Rails.application.routes.draw do
  resources :match_teams
  resources :courses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "players#index"
  resources :players
  resources :teams
  resources :matches
end
