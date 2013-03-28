require 'test_helper'

class TokenUsersControllerTest < ActionController::TestCase
  setup do
    @token_user = token_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:token_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create token_user" do
    assert_difference('TokenUser.count') do
      post :create, :token_user => { :grupa => @token_user.grupa, :token => @token_user.token }
    end

    assert_redirected_to token_user_path(assigns(:token_user))
  end

  test "should show token_user" do
    get :show, :id => @token_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @token_user
    assert_response :success
  end

  test "should update token_user" do
    put :update, :id => @token_user, :token_user => { :grupa => @token_user.grupa, :token => @token_user.token }
    assert_redirected_to token_user_path(assigns(:token_user))
  end

  test "should destroy token_user" do
    assert_difference('TokenUser.count', -1) do
      delete :destroy, :id => @token_user
    end

    assert_redirected_to token_users_path
  end
end
