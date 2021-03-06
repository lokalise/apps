# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :lokalise, ENV['OAUTH2_CLIENT_ID'], ENV['OAUTH2_CLIENT_SECRET'],
           scope: 'read_projects write_files'
end
