# frozen_string_literal: true

require 'ruby_lokalise_api'

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:notify]

  def new; end

  def create
    api_client.create_webhook params[:project_id],
                              url: 'https://lokalise-webhooks-rails.herokuapp.com/webhooks/notify',
                              events: %w[project.key.added]

    redirect_to root_path
  end

  def notify
    if params[:event] == 'project.key.added'
      project_id = params[:project][:id]
      key_id = params[:key][:id]

      api_client.create_comments project_id, key_id, [
        { comment: '@Bob could you please double check this key to make sure it complies with our requirements?' }
      ]

      api_client.update_key project_id, key_id, is_hidden: true
    end
    
    if params[:event] == 'project.translations.updated'
      puts "Project name: #{params[:project][:name]}"
      puts "User name: #{params[:user][:full_name]}"

      params[:translations].each do |translation|
        puts "Translation ID: #{translation[:id]}"
        puts "Translation value: #{translation[:value]}"
        puts "Language: #{translation[:language][:name]}"
        puts "Key: #{translation[:key][:name]}"
      end
    end

    head :ok
  end

  private

  def api_client
    @client ||= RubyLokaliseApi.client ENV['LOKALISE_API_TOKEN']
  end
end
