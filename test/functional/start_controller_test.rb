require 'test_helper'

class StartControllerTest < ActionController::TestCase
  test "should get refresh_data" do
    get :refresh_data
    assert_response :success
  end

  test "should get generate_tokens" do
    get :generate_tokens
    assert_response :success
  end

  test "should get set_time_frame" do
    get :set_time_frame
    assert_response :success
  end

end
