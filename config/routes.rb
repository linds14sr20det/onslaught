Rails.application.routes.draw do

  root   'application#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :cohorts do
    get :players, on: :member
  end
  resources :tickets, only: [:index, :show] do
    post :add_to_cart, on: :member
    get :remove_from_cart, on: :collection
    get :cart, on: :collection
  end
  post '/checkout' => 'paypal#checkout'
  post '/execute' =>  'paypal#execute'
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
