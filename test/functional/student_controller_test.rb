require 'test_helper'

class StudentControllerTest < ActionController::TestCase
  test "should get listare" do
    get :listare
    assert_response :success
  end

  test "should get completare" do
    get :completare
    assert_response :success
  end

end
