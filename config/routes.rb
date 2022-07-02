Rails.application.routes.draw do
  resources :relationships
  resources :likes
  resources :comments
  resources :recipe_ingredients
  resources :ingredients
  resources :recipes
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static#homepage"
end
