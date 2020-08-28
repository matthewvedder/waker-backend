Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # post 'user_token' => 'user_token#create'
  resources :users
  resources :asana_instances
  resources :likes
  resources :comments
  # asanas
  resources :asanas
  get 'asana-tags', to: 'asanas#tags'

  # sequences
  resources :sequences
  get 'sequences/:id/pdf', to: 'sequences#pdf'
end
