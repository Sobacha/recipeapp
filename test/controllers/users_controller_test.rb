require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "users routings" do
    assert_routing({method: 'get', path: 'signup'},
                   {controller: "users", action: "new"})
    assert_routing({method: 'post', path: 'signup'},
                   {controller: "users", action: "create"})
    assert_routing({method: 'get', path: 'users/1/edit'},
                   {controller: "users", action: "edit", id: "1"})
    assert_routing({method: 'patch', path: 'users/1'},
                   {controller: "users", action: "update", id: "1"})
    assert_routing({method: 'get', path: 'users/1'},
                   {controller: "users", action: "show", id: "1"})
    assert_routing({method: 'delete', path: 'users/1'},
                   {controller: "users", action: "destroy", id: "1"})
  end

  test "need to login" do
    pass
  end

end
