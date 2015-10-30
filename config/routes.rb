Rails.application.routes.draw do
  resources :bookings
  resources :transactions
  resources :posts
  resources :post_images
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
