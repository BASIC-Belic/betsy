Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'
  resources :users, only: [:index, :show, :shop]

  resources :orders, :orderitems, :items, :reviews

  get '/shop', to: 'user#shop', as: shop_path

  get '/history', to: 'user#orders', as: orders_path
end
