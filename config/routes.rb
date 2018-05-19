# frozen_string_literal: true

Rails.application.routes.draw do
  get 'login' => 'sessions#new', as: :login
  match 'logout' => 'sessions#destroy', as: :logout, via: %i[get delete]

  constraints provider: /#{OmniAuth.registered_providers.join('|')}/ do
    get 'login/with/:provider' => 'sessions#oauth', as: :oauth_login
    match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  end

  resources :productions, only: %i[index]
  resources :reviews, only: %i[new create] do
    member do
      post :submit
    end
  end

  root to: 'reviews#index'
end
