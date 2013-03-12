require 'test_helper'

class AutentificareControllerTest < ActionController::TestCase
  test "should get autentifica" do
    get :autentifica
    assert_response :success
  end

end
