Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "splash#index"
  resources :users
  resources :groups
  resources :contracts do
    get :new_contract, on: :collection
  end


end
