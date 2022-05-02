# frozen_string_literal: true

require 'test_helper'

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get downloads_new_url
    assert_response :success
  end

  test 'should get create' do
    get downloads_create_url
    assert_response :success
  end
end
