Rails.application.routes.draw do
  mount ReportsKit::Engine, at: '/'
  namespace :admin do
    resources :users
    resources :admin_users
    resources :working_days

    root to: 'users#index'
  end
  
  resources :reports, only: :index
  resources :working_days
  devise_for :users
  root to: 'dashboard#index'
  get 'users', to: 'dashboard#show'
end

