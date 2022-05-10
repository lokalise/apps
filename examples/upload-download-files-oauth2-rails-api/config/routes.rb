# frozen_string_literal: true

Rails.application.routes.draw do
  resources :downloads, only: %i[new create]
  resources :uploads, only: %i[new create]

  resources :oauth2_flows, only: %i[new] do
    collection do
      get 'callback'
      get 'log_out'
    end
  end

  resources :projects, only: %i[index] do
    collection do
      post 'choose'
    end
  end

  root 'oauth2_flows#new'
end
