require 'test_helper'

class PropCasapiInfo2sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prop_casapi_info2 = prop_casapi_info2s(:one)
  end

  test "should get index" do
    get prop_casapi_info2s_url
    assert_response :success
  end

  test "should get new" do
    get new_prop_casapi_info2_url
    assert_response :success
  end

  test "should create prop_casapi_info2" do
    assert_difference('PropCasapiInfo2.count') do
      post prop_casapi_info2s_url, params: { prop_casapi_info2: { contacto: @prop_casapi_info2.contacto, correo: @prop_casapi_info2.correo, descripcion: @prop_casapi_info2.descripcion, direccion: @prop_casapi_info2.direccion, estado: @prop_casapi_info2.estado, lat: @prop_casapi_info2.lat, lng: @prop_casapi_info2.lng, objetivo: @prop_casapi_info2.objetivo, precio: @prop_casapi_info2.precio, precio_uf: @prop_casapi_info2.precio_uf, programa: @prop_casapi_info2.programa, prop_id: @prop_casapi_info2.prop_id, publicacion: @prop_casapi_info2.publicacion, sector: @prop_casapi_info2.sector, sup_construida: @prop_casapi_info2.sup_construida, sup_terreno: @prop_casapi_info2.sup_terreno, superficie: @prop_casapi_info2.superficie, telefono: @prop_casapi_info2.telefono, valor_uf: @prop_casapi_info2.valor_uf, zona: @prop_casapi_info2.zona } }
    end

    assert_redirected_to prop_casapi_info2_url(PropCasapiInfo2.last)
  end

  test "should show prop_casapi_info2" do
    get prop_casapi_info2_url(@prop_casapi_info2)
    assert_response :success
  end

  test "should get edit" do
    get edit_prop_casapi_info2_url(@prop_casapi_info2)
    assert_response :success
  end

  test "should update prop_casapi_info2" do
    patch prop_casapi_info2_url(@prop_casapi_info2), params: { prop_casapi_info2: { contacto: @prop_casapi_info2.contacto, correo: @prop_casapi_info2.correo, descripcion: @prop_casapi_info2.descripcion, direccion: @prop_casapi_info2.direccion, estado: @prop_casapi_info2.estado, lat: @prop_casapi_info2.lat, lng: @prop_casapi_info2.lng, objetivo: @prop_casapi_info2.objetivo, precio: @prop_casapi_info2.precio, precio_uf: @prop_casapi_info2.precio_uf, programa: @prop_casapi_info2.programa, prop_id: @prop_casapi_info2.prop_id, publicacion: @prop_casapi_info2.publicacion, sector: @prop_casapi_info2.sector, sup_construida: @prop_casapi_info2.sup_construida, sup_terreno: @prop_casapi_info2.sup_terreno, superficie: @prop_casapi_info2.superficie, telefono: @prop_casapi_info2.telefono, valor_uf: @prop_casapi_info2.valor_uf, zona: @prop_casapi_info2.zona } }
    assert_redirected_to prop_casapi_info2_url(@prop_casapi_info2)
  end

  test "should destroy prop_casapi_info2" do
    assert_difference('PropCasapiInfo2.count', -1) do
      delete prop_casapi_info2_url(@prop_casapi_info2)
    end

    assert_redirected_to prop_casapi_info2s_url
  end
end
