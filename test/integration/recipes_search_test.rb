require 'test_helper'

class RecipesSearchTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:three)
    @food = foods(:six)
  end

  test "Find proper recipes by food" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    assert_select "tr#5"
    assert_select "td#5", text: "Spinach"
    assert_select "tr#6"
    assert_select "td#6", text: "Tofu"
    assert_select "tr#7"
    assert_select "td#7", text: "Orange"

    get "/recipes/search/Tofu?id=6"
    assert_select "tr#4"
    assert_select "td#4", text: "Mabo Tofu"
    assert_select "tr#6"
    assert_select "td#6", text: "Hiyayakko"
    assert_select "tr#7"
    assert_select "td#7", text: "Teriyaki tofu"
  end

end
