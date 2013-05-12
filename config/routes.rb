WorldOfRobotics::Application.routes.draw do
  root :to => 'home#index'

  resources :products
  resources :categories
end
