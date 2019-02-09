Rails.application.routes.draw do
  root to: 'products#index'

  resources :products
  resources :product_files
  resources :categories
end
