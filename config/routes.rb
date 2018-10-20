Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'

  resources :users, only: [:show, :shop, :orders]
  resources :orders, :orderitems, :items, :reviews, :category

  get "/auth/:provider/callback", to: "sessions#create"
  post '/logout', to: 'sessions#logout', as: 'logout'

  # get '/shop', to: 'user#shop', as: shop_path
end
