Rails.application.routes.draw do
  resources :bookings
  resources :transactions
  resources :posts
  get "posts/book/:id" => "posts#book"
  resources :post_images
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
