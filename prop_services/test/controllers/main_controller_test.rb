require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_index_url
    assert_response :success
  end

  test "should get site_request" do
    get main_site_request_url
    assert_response :success
  end

  test "should get site_response" do
    get main_site_response_url
    assert_response :success
  end

end
