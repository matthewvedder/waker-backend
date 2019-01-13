Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users
  resources :asanas
  resources :sequences
  resources :asana_instances
end
