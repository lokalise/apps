# frozen_string_literal: true

require 'ruby_lokalise_api'

class UploadsController < ApplicationController
  before_action :check_token
  before_action :check_project_id

  def new; end

  def create
    client = RubyLokaliseApi.oauth2_client session[:lokalise_token]
    #client = RubyLokaliseApi.client ENV['LOKALISE_API_KEY']

    file_content = File.read "#{Rails.root}/config/locales/en.yml"

    client.upload_file ENV['LOKALISE_PROJECT_ID'],
                       data: Base64.strict_encode64(file_content.strip),
                       filename: 'en.yml',
                       lang_iso: 'en'

    redirect_to uploads_new_path
  end
end
