require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

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

  resources :users do
    member do
      get '/product', to: 'users#my_products'
      get 'my_orders', to: 'orders#show'
    end
  end

  resources :roles

  resources :products 
  get '/all_products', to: 'products#all_products'

  resources :product_stocks

  resources :categories 

  resources :carts, only: [:index, :destroy]
  post 'carts/remove'             
  post 'carts/increase'
  post 'carts/decrease'

  resources :cart_products

  resources :orders, only: [ :index ]
  get 'all_orders', to: 'orders#all_orders'
  
  resources :order_items, only: [ :update ] 
  post 'order_items/:id', to: 'order_items#create', as: 'create_order' 

  resources :addresses, only: [:create, :destroy]

  get 'checkout', to: 'checkout#index'
end
