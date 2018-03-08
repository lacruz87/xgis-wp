require 'test_helper'

class PropsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prop = props(:one)
  end

  test "should get index" do
    get props_url
    assert_response :success
  end

  test "should get new" do
    get new_prop_url
    assert_response :success
  end

  test "should create prop" do
    assert_difference('Prop.count') do
      post props_url, params: { prop: { bo_1: @prop.bo_1, bo_2: @prop.bo_2, bo_3: @prop.bo_3, check: @prop.check, dt_1: @prop.dt_1, dt_2: @prop.dt_2, dt_3: @prop.dt_3, dt_4: @prop.dt_4, fl_1: @prop.fl_1, fl_2: @prop.fl_2, fl_3: @prop.fl_3, int_1: @prop.int_1, int_2: @prop.int_2, int_3: @prop.int_3, lat: @prop.lat, lng: @prop.lng, m2_terreno: @prop.m2_terreno, origen: @prop.origen, precio_uf: @prop.precio_uf, rank: @prop.rank, str_1: @prop.str_1, str_2: @prop.str_2, str_3: @prop.str_3, uf_x_m2: @prop.uf_x_m2 } }
    end

    assert_redirected_to prop_url(Prop.last)
  end

  test "should show prop" do
    get prop_url(@prop)
    assert_response :success
  end

  test "should get edit" do
    get edit_prop_url(@prop)
    assert_response :success
  end

  test "should update prop" do
    patch prop_url(@prop), params: { prop: { bo_1: @prop.bo_1, bo_2: @prop.bo_2, bo_3: @prop.bo_3, check: @prop.check, dt_1: @prop.dt_1, dt_2: @prop.dt_2, dt_3: @prop.dt_3, dt_4: @prop.dt_4, fl_1: @prop.fl_1, fl_2: @prop.fl_2, fl_3: @prop.fl_3, int_1: @prop.int_1, int_2: @prop.int_2, int_3: @prop.int_3, lat: @prop.lat, lng: @prop.lng, m2_terreno: @prop.m2_terreno, origen: @prop.origen, precio_uf: @prop.precio_uf, rank: @prop.rank, str_1: @prop.str_1, str_2: @prop.str_2, str_3: @prop.str_3, uf_x_m2: @prop.uf_x_m2 } }
    assert_redirected_to prop_url(@prop)
  end

  test "should destroy prop" do
    assert_difference('Prop.count', -1) do
      delete prop_url(@prop)
    end

    assert_redirected_to props_url
  end
end
