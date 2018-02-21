require 'test_helper'

class ServiciosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get servicios_index_url
    assert_response :success
  end

  test "should get prueba" do
    get servicios_prueba_url
    assert_response :success
  end

  test "should get comunas_map" do
    get servicios_comunas_map_url
    assert_response :success
  end

  test "should get comuna_request" do
    get servicios_comuna_request_url
    assert_response :success
  end

  test "should get comuna_response" do
    get servicios_comuna_response_url
    assert_response :success
  end

  test "should get predios_map" do
    get servicios_predios_map_url
    assert_response :success
  end

  test "should get predios_request" do
    get servicios_predios_request_url
    assert_response :success
  end

  test "should get predios_response" do
    get servicios_predios_response_url
    assert_response :success
  end

end
