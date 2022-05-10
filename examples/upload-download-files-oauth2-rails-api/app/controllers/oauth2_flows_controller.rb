# frozen_string_literal: true

require 'ruby_lokalise_api'

class Oauth2FlowsController < ApplicationController
  def new
    @auth_url = auth_client.auth scope: %(read_projects read_files write_files),
                                 redirect_uri: 'http://localhost:3000/oauth2_flows/callback',
                                 state: rand(10_000)
  end

  def callback
    response = auth_client.token params[:code]
    session[:lokalise_token] = response['access_token']
    session[:lokalise_refresh] = response['refresh_token']

    redirect_to new_oauth2_flow_path
  end

  def log_out
    session.delete :lokalise_token
    session.delete :lokalise_refresh
    session.delete :lokalise_project_id
    redirect_to new_oauth2_flow_path
  end

  private

  def auth_client
    RubyLokaliseApi.auth_client ENV['OAUTH2_CLIENT_ID'], ENV['OAUTH2_CLIENT_SECRET']
  end
end
