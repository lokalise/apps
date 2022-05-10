# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def check_token
    redirect_to new_oauth2_flow_path unless session[:lokalise_token].present?
  end

  def check_project_id
    redirect_to new_oauth2_flow_path unless session[:lokalise_project_id].present?
  end
end
