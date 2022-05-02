# frozen_string_literal: true

Rails.application.routes.draw do
  get 'downloads/new'
  post 'downloads/create'
  get 'uploads/new'
  post 'uploads/create'

  get 'oauth2_flows/new'
  get 'oauth2_flows/callback'
  get 'oauth2_flows/log_out'

  get 'projects', to: 'projects#index'
  post 'projects/choose'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'pages', to: 'pages#index'
  get '/auth/:provider/callback', to: 'pages#create'
end
