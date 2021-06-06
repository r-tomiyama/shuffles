Rails.application.routes.draw do
  root to: 'sessions#new'

  get 'signup', to: 'users#new'
  resources :users, only: [:create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
end
