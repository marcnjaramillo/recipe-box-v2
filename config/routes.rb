Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :recipes
  devise_for :users

  resources :profile, param: :username, only: [:show] do
    member do
      get :recipes, :following, :followers
    end
  end

  post 'profile/follow', to: 'profile#follow'
  delete 'profile/unfollow', to: 'profile#unfollow'

  # Defines the root path route ("/")
  root "homepage#index"
end
