Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "accounts#home"
  resources :accounts
  
  resources :shops
  resources :products
  resources :categories
  
  resource :cart, only: [:show] do
    delete :clear, on: :collection
  end
  
  resources :cart_items, only: [:create, :update, :destroy]
end
