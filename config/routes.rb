Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'
  resources :users, :orders, :orderitems, :items, :reviews

  get "/auth/:provider/callback", to: "sessions#create"
  post '/logout', to: 'sessions#logout', as: 'logout'
end
