# frozen_string_literal: true

Rails.application.routes.draw do
  get 'login' => 'sessions#new', as: :login
  match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]

  resources :reviews, only: %i[new]

  root to: 'reviews#index'
end
