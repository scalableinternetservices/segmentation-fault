Rails.application.routes.draw do
  resources :bookings
  resources :transactions
  resources :posts
  post "posts/book/" => "posts#book"
  resources :post_images
  root to: 'visitors#index'
  devise_for :users
  get "users/profile/" => "users#profile" , as: 'user_profile'
  resources :users
end
