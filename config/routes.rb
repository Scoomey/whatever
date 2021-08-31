Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :movies, only: [:show]

  resources :foods, only: [:show]

  resources :pairings, only: [:create, new, :show, :index]
end
