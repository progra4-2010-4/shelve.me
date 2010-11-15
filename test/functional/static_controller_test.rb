require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test "should get index" do
    get :index
    assert_response :success
    assert_select "a[href=/users/sign_in]", :text=>"Login"
    assert_select "a[href=/users/sign_up]", :text=>"Register"
  end
end
