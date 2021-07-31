Rails.application.routes.draw do
  root to: 'shuffle_lists#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  resources :shuffle_lists, only: %i[index create edit update destroy]
  get 'execute', to: 'shuffle_lists#execute'
end
