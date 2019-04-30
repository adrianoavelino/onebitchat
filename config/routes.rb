Rails.application.routes.draw do
  resources :talks, only: [:show]

  resources :teams, only: [:index, :create, :destroy]
  resources :channels, only: [:create]
  get '/:slug', to: 'teams#show'
  root to: 'teams#index'
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
