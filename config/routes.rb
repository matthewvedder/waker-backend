Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users
  resources :asana_instances

  # asanas
  resources :asanas
  get 'asana-tags', to: 'asanas#tags'

  # sequences
  resources :sequences
  get 'sequences/:id/pdf', to: 'sequences#pdf'
end
