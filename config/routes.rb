Rails.application.routes.draw do

  root "home#index"

  resources :articles

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]

end
