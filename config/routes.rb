Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'

  resources :users, only: [:show, :shop, :orders]
  resources :orders, :items, :reviews, :category

  resources :items do
    resources :order_items, only: [:create]
  end

  get "/auth/:provider/callback", to: "sessions#create"
  post '/logout', to: 'sessions#logout', as: 'logout'

  get '/shop', to: 'users#shop', as: 'shop'
end
