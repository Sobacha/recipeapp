require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "sessions routings" do
    assert_routing({method: 'get', path: 'login'},
                   {controller: "sessions", action: "new"})
    assert_routing({method: 'post', path: 'login'},
                   {controller: "sessions", action: "create"})
    assert_routing({method: 'delete', path: 'logout'},
                   {controller: "sessions", action: "destroy"})
  end

end
