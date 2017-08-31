require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @non_autho_user = users(:two)
  end

  test "user must log in to edit" do
    # edit
    get edit_user_path(@user)
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."
    # update
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: "foo@invalid",
                                              password: "changin_password",
                                              password_confirmation: "changing_password"}}
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."
  end

  test "non-authorized user can't edit other users' info" do
    get login_path
    post login_path, params: { session: { email: @non_autho_user.email,
                                          password: 'password' } }
    assert is_logged_in?

    get edit_user_path(@user)
    follow_redirect!
    assert_template 'welcome/home'
    assert_select "div.alert", text: "No authorization to access."
  end


  test "unsuccessful edit with invalid input" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?

    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar"}}
    assert_template 'users/edit'
    assert_select "div.error-main", text: "The form contains 4 errors."
  end

  test "successful edit" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?

    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
