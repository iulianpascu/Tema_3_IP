require 'test_helper'

class ActivareButonsControllerTest < ActionController::TestCase
  setup do
    @activare_buton = activare_butons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:activare_butons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create activare_buton" do
    assert_difference('ActivareButon.count') do
      post :create, activare_buton: { data_inceput: @activare_buton.data_inceput, data_sf: @activare_buton.data_sf }
    end

    assert_redirected_to activare_buton_path(assigns(:activare_buton))
  end

  test "should show activare_buton" do
    get :show, id: @activare_buton
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @activare_buton
    assert_response :success
  end

  test "should update activare_buton" do
    put :update, id: @activare_buton, activare_buton: { data_inceput: @activare_buton.data_inceput, data_sf: @activare_buton.data_sf }
    assert_redirected_to activare_buton_path(assigns(:activare_buton))
  end

  test "should destroy activare_buton" do
    assert_difference('ActivareButon.count', -1) do
      delete :destroy, id: @activare_buton
    end

    assert_redirected_to activare_butons_path
  end
end
