Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :movies

  resources :chatrooms, only: :show do
    resources :messages, only: [ :create, :new ]
  end


  resources :foods, only: :show

  resources :pairings, except: :destroy

  get "survey", to: "pages#survey"
  post "otp", to: "pairings#otp"
end
