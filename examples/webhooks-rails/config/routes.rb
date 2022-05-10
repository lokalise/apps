# frozen_string_literal: true

Rails.application.routes.draw do
  resources :webhooks, only: %i[new create] do
    collection do
      post 'notify'
    end
  end

  root 'webhooks#new'
end
