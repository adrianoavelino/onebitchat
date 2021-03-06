require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  resources :talks, only: [:show]
  resources :team_users
  resources :teams, only: [:create, :destroy]
  resources :channels, only: [:show, :create, :destroy]
  resources :invitations, only: [:index, :create, :update]
  post '/notifications', to: 'notifications#update_or_create'
  get '/:slug', to: 'teams#show'
  root to: 'teams#index'
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
