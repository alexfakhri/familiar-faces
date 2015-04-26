Rails.application.routes.draw do

  root "home#index"

  get 'tags/:tag', to: 'articles#index', as: :tag

  resources :articles

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]

end
