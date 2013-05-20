WorldOfRobotics::Application.routes.draw do
  root :to => 'home#index'

  resources :products
  resources :categories
  resources :line_items
  resources :carts, only: [:show]

  resources :admin, only: [:index]
end
