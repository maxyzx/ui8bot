Rails.application.routes.draw do
  root to: 'products#index'

  get :analytics, to: "analytics#index"

  resources :products
  resources :product_files
  resources :categories
end
