Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "products#index"

  get '/search', to: "products#search"

  post 'carts/remove'             

  post 'carts/increase'
  post 'carts/decrease'

  resources :roles

  resources :carts, only: [:destroy]

  resources :cart_products
  
  resources :users do
    member do
      get '/product', to: 'users#my_products'
      get 'cart', to: 'carts#show'
      get 'orders', to: 'orders#index'
      get 'my_orders', to: 'orders#show'
    end
  end

  resources :products 
  resources :product_stocks

  resources :order_items
 
  resources :categories do
    member do
      get '/product', to: 'categories#products'
    end
  end
  
  
end
