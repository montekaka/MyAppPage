require 'test_helper'

class DemosControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

end
