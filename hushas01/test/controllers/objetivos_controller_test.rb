require 'test_helper'

class ObjetivosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @objetivo = objetivos(:one)
  end

  test "should get index" do
    get objetivos_url
    assert_response :success
  end

  test "should get new" do
    get new_objetivo_url
    assert_response :success
  end

  test "should create objetivo" do
    assert_difference('Objetivo.count') do
      post objetivos_url, params: { objetivo: { comuna_id: @objetivo.comuna_id, constructibilidad: @objetivo.constructibilidad, premio_fusion: @objetivo.premio_fusion, target_uf_m2: @objetivo.target_uf_m2, zona: @objetivo.zona, zona_prc: @objetivo.zona_prc } }
    end

    assert_redirected_to objetivo_url(Objetivo.last)
  end

  test "should show objetivo" do
    get objetivo_url(@objetivo)
    assert_response :success
  end

  test "should get edit" do
    get edit_objetivo_url(@objetivo)
    assert_response :success
  end

  test "should update objetivo" do
    patch objetivo_url(@objetivo), params: { objetivo: { comuna_id: @objetivo.comuna_id, constructibilidad: @objetivo.constructibilidad, premio_fusion: @objetivo.premio_fusion, target_uf_m2: @objetivo.target_uf_m2, zona: @objetivo.zona, zona_prc: @objetivo.zona_prc } }
    assert_redirected_to objetivo_url(@objetivo)
  end

  test "should destroy objetivo" do
    assert_difference('Objetivo.count', -1) do
      delete objetivo_url(@objetivo)
    end

    assert_redirected_to objetivos_url
  end
end
