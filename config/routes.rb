Rails.application.routes.draw do

  root "home#index"

  get 'tags/:tag', to: 'articles#index', as: :tag

  resources :articles, :admin

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]

  scope :api do
    get "/results(.:format)" => "results#index"
    get "/results/:id(.:format)" => "results#show"
  end

end
