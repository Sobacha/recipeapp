require 'test_helper'

class RecipesSearchTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:three)
    @food = foods(:six)
  end

  test "user must log in to search recipes by food" do
    get "/recipes/search/Tofu?id=6"
    follow_redirect!
    assert login_error_msg
  end

  test "user can't search other users' recipes by other users' food" do
    assert log_in(@user)

    get "/recipes/search/Salmon?id=1"
    follow_redirect!
    assert unauthorized_data_error_msg("food")
  end

  test "find proper recipes by food" do
    assert log_in(@user)

    get foods_path
    assert_select "li#6", text: "Tofu"
    assert_select "li#5", text: "Spinach"
    assert_select "li#7", text: "Orange"

    get "/recipes/search/Tofu?id=6"
    assert_select "div#4", text: "Mabo Tofu"
    assert_select "div#6", text: "Hiyayakko"
    assert_select "div#7", text: "Teriyaki tofu"
  end

end
