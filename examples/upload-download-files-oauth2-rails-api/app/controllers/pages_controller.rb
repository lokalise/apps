# frozen_string_literal: true

class PagesController < ApplicationController
  def index
  end

  def create
    render plain: request.env['omniauth.auth']['credentials']
  end
end
