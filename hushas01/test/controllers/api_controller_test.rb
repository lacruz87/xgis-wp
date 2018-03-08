require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get api_new_url
    assert_response :success
  end

end
