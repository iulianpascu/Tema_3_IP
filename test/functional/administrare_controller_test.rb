require 'test_helper'

class AdministrareControllerTest < ActionController::TestCase
  test "should get listare" do
    get :listare
    assert_response :success
  end

  test "should get adaugare" do
    get :adaugare
    assert_response :success
  end

  test "should get generare" do
    get :generare
    assert_response :success
  end

end
