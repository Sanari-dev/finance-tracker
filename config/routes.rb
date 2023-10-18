Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
  get "my_portfolio", to: 'users#my_portfolio'  
  get "search_stock", to: 'stocks#search'  
  get "my_friends", to: 'users#my_friends'
  get "search_friend", to: 'users#search'  
end
