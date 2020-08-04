Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users
  resources :asanas
  resources :asana_instances
  # sequences
  resources :sequences
  get 'sequences/:id/pdf', to: 'sequences#pdf'
end
