Rails.application.routes.draw do

  root "articles#index"

  get 'tags/:tag', to: 'articles#index', as: :tag

  resources :articles, :admin

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]

end
