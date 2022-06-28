class ProcessorsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[preprocess postprocess]

  def preprocess
    payload = params

    payload[:collection][:keys].each do |key|
      key[:translations].map! do |trans|
        trans[:translation].gsub!(/BANNED/, '')
        trans
      end
    end

    render json: payload
  end

  def postprocess
    payload = params

    payload[:collection][:keys].each do |key|
      key[:translations].map! do |trans|
        trans[:translation].gsub!(/BANNED/, '')
        trans
      end
    end

    render json: payload
  end
end