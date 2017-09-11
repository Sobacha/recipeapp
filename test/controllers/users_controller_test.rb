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



  test "user must log in to see profile" do
    get user_path(@authorized_user)
    follow_redirect!
    assert login_error_msg
  end

  # test "user must log in to edit/update" --> users_edit_test.rb

  test "user must log in to delete itself" do
    delete user_path(@authorized_user)
    follow_redirect!
    assert login_error_msg
  end

  test "user can't see other users' profile" do
    assert log_in(@unauthorized_user)

    get user_path(@authorized_user)
    follow_redirect!
    assert unauthorized_data_error_msg("user")
  end

  test "user can't delete other users" do
    assert log_in(@unauthorized_user)

    delete user_path(@authorized_user)
    follow_redirect!
    assert unauthorized_data_error_msg("user")
  end

end
