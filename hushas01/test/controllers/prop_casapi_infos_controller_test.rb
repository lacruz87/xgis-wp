require 'test_helper'

class PropCasapiInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prop_casapi_info = prop_casapi_infos(:one)
  end

  test "should get index" do
    get prop_casapi_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_prop_casapi_info_url
    assert_response :success
  end

  test "should create prop_casapi_info" do
    assert_difference('PropCasapiInfo.count') do
      post prop_casapi_infos_url, params: { prop_casapi_info: { descripcion: @prop_casapi_info.descripcion, direccion: @prop_casapi_info.direccion, precio: @prop_casapi_info.precio, programa: @prop_casapi_info.programa, prop_id: @prop_casapi_info.prop_id, publicacion: @prop_casapi_info.publicacion, sector: @prop_casapi_info.sector, sup_construida: @prop_casapi_info.sup_construida, sup_terreno: @prop_casapi_info.sup_terreno, superficie: @prop_casapi_info.superficie } }
    end

    assert_redirected_to prop_casapi_info_url(PropCasapiInfo.last)
  end

  test "should show prop_casapi_info" do
    get prop_casapi_info_url(@prop_casapi_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_prop_casapi_info_url(@prop_casapi_info)
    assert_response :success
  end

  test "should update prop_casapi_info" do
    patch prop_casapi_info_url(@prop_casapi_info), params: { prop_casapi_info: { descripcion: @prop_casapi_info.descripcion, direccion: @prop_casapi_info.direccion, precio: @prop_casapi_info.precio, programa: @prop_casapi_info.programa, prop_id: @prop_casapi_info.prop_id, publicacion: @prop_casapi_info.publicacion, sector: @prop_casapi_info.sector, sup_construida: @prop_casapi_info.sup_construida, sup_terreno: @prop_casapi_info.sup_terreno, superficie: @prop_casapi_info.superficie } }
    assert_redirected_to prop_casapi_info_url(@prop_casapi_info)
  end

  test "should destroy prop_casapi_info" do
    assert_difference('PropCasapiInfo.count', -1) do
      delete prop_casapi_info_url(@prop_casapi_info)
    end

    assert_redirected_to prop_casapi_infos_url
  end
end
