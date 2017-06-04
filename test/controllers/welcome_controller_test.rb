require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_url
    assert_response :success
  end

  test "welcome routings" do
    assert_routing({method: 'get', path: '/'},
                   {controller: "welcome", action: "home"})
  end

end
