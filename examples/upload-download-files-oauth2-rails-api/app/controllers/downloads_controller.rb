# frozen_string_literal: true

require 'ruby_lokalise_api'
require 'open-uri'
require 'zip'

class DownloadsController < ApplicationController
  before_action :check_token
  before_action :check_project_id

  def new; end

  def create
    client = RubyLokaliseApi.oauth2_client session[:lokalise_token] #.client ENV['LOKALISE_API_KEY']

    zip_file = client.download_files(ENV['LOKALISE_PROJECT_ID'],
                                     format: 'yaml',
                                     placeholder_format: :icu,
                                     yaml_include_root: true,
                                     original_filenames: true,
                                     directory_prefix: '',
                                     indentation: '2sp',
                                     filter_langs: %w[en])['bundle_url']

    open_and_process zip_file

    redirect_to downloads_new_path
  end

  private

  def open_and_process(path)
    Zip::File.open_buffer(open_remote(path)) do |zip|
      zip.each do |entry|
        next unless entry.name == 'en.yml'
        process_zip(entry)
      end
    end
  end

  def open_remote(path)
    parsed_path = URI.parse(path)
    parsed_path.open
  end

  def process_zip(entry)
    data = YAML.safe_load(entry.get_input_stream.read)

    File.open(File.join(Rails.root, 'config', 'locales', entry.name), 'w+:UTF-8') do |f|
      f.write data.to_yaml
    end
  end
end
