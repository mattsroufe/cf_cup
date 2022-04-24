Rails.application.routes.draw do
  resources :holes
  resources :scores
  resources :sessions
  get 'home/index'
  get 'leaderboard/index'
  resources :match_teams
  resources :courses
  resources :matches
  resources :teams
  resources :players
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
