require 'test_helper'

class GrupasControllerTest < ActionController::TestCase
  setup do
    @grupa = grupas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grupas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grupa" do
    assert_difference('Grupa.count') do
      post :create, grupa: { grupa: @grupa.grupa, studenti: @grupa.studenti }
    end

    assert_redirected_to grupa_path(assigns(:grupa))
  end

  test "should show grupa" do
    get :show, id: @grupa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grupa
    assert_response :success
  end

  test "should update grupa" do
    put :update, id: @grupa, grupa: { grupa: @grupa.grupa, studenti: @grupa.studenti }
    assert_redirected_to grupa_path(assigns(:grupa))
  end

  test "should destroy grupa" do
    assert_difference('Grupa.count', -1) do
      delete :destroy, id: @grupa
    end

    assert_redirected_to grupas_path
  end
end
