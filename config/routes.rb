Rails.application.routes.draw do
  resources :poses
  resources :sequences
  post 'user_token' => 'user_token#create'
  resources :users
end
