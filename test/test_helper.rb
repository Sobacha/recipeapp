ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Returns true if a test user is logged in.
  def setup
    @authorized_user = users(:one)
    @unauthorized_user = users(:two)
    @recipe = recipes(:two)
    @food = foods(:two)
  end

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in(user)
    get login_path
    post login_path, params: { session: { email: user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to user
    follow_redirect!
    assert_template 'users/show'
  end

  def login_error_msg
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."
  end
  # separate them
  def unauthorized_data_error_msg(userORrecipeORfood)
    if userORrecipeORfood == "user"
      assert_template 'home'
      assert_select "div.alert", text: "No authorization to access."
    elsif userORrecipeORfood == "recipe"
      assert_template 'index'
      assert_select "div.alert", text: "You don't have that recipe!"
    elsif userORrecipeORfood == "food"
      assert_template 'index'
      assert_select "div.alert", text: "You don't have that food!"
    end
  end

end
