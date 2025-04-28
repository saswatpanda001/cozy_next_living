Rails.application.routes.draw do
  get "orders/index"
  get "orders/show"
  # Authentication routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'dashboard', to: 'dashboard#index'
  # Public routes
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]

  
  get 'signup', to: 'admins#new'
  post 'signup', to: 'admins#create'

  # Admin routes
  namespace :backend do
    resources :dashboard, only: [:index]
    resources :products
    resources :categories
    
    resources :pages, except: [:show]  # We'll use custom actions for about/contact
  end


  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    patch 'update_quantity', to: 'carts#update_quantity'
    delete 'remove_item', to: 'carts#remove_item'
  end


  resources :checkout, only: [:new, :create]
  resources :orders, only: [:index, :show]
  




  
  
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  
  root 'home#index'


end