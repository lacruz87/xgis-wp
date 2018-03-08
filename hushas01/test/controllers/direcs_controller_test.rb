require 'test_helper'

class DirecsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @direc = direcs(:one)
  end

  test "should get index" do
    get direcs_url
    assert_response :success
  end

  test "should get new" do
    get new_direc_url
    assert_response :success
  end

  test "should create direc" do
    assert_difference('Direc.count') do
      post direcs_url, params: { direc: { Argis_json: @direc.Argis_json, direccion: @direc.direccion, latitude: @direc.latitude, longitude: @direc.longitude, zona: @direc.zona } }
    end

    assert_redirected_to direc_url(Direc.last)
  end

  test "should show direc" do
    get direc_url(@direc)
    assert_response :success
  end

  test "should get edit" do
    get edit_direc_url(@direc)
    assert_response :success
  end

  test "should update direc" do
    patch direc_url(@direc), params: { direc: { Argis_json: @direc.Argis_json, direccion: @direc.direccion, latitude: @direc.latitude, longitude: @direc.longitude, zona: @direc.zona } }
    assert_redirected_to direc_url(@direc)
  end

  test "should destroy direc" do
    assert_difference('Direc.count', -1) do
      delete direc_url(@direc)
    end

    assert_redirected_to direcs_url
  end
end
