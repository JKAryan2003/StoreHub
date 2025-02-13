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
  root "main#index"

  get "menu", to: "menu#index"
  get '/search', to: "products#search"

  post 'cart/add'
  post 'cart/remove'             

  post 'cart/increase'
  post 'cart/decrease'

  resources :roles
  
  resources :users do
    member do
      get '/product', to: 'users#my_products'
      get 'cart', to: 'cart#show'
    end
  end

  resources :products 
  resources :product_stocks
 
  resources :categories do
    member do
      get '/product', to: 'categories#products'
    end
  end
  
  
end
