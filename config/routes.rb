Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :movies, only: :show

  resources :foods, only: :show

  resources :pairings, except: :destroy
end
