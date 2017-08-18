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
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."
  end

  # test "user must log in to edit/update" --> users_edit_test.rb

  test "user must log in to delete itself" do
    delete user_path(@authorized_user)
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."
  end

  test "user can't see other users' profile" do
    get login_path
    post login_path, params: { session: { email: @non_autho_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @non_autho_user
    follow_redirect!
    assert_template 'users/show'

    get user_path(@authorized_user)
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "No authorization to access."
  end

  test "user can't delete other users" do
    get login_path
    post login_path, params: { session: { email: @non_autho_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @non_autho_user
    follow_redirect!
    assert_template 'users/show'

    delete user_path(@authorized_user)
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "No authorization to access."
  end

end
