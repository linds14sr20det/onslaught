Rails.application.routes.draw do

  root   'application#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :cohorts
  resources :tickets, only: [:index, :show] do
    post :add_to_cart, on: :member
  end
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
