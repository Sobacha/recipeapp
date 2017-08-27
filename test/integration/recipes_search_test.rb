require 'test_helper'

class RecipesSearchTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:three)
    @food = foods(:six)
  end

  test "find proper recipes by food" do
    assert log_in(@user)

    get foods_path
    assert_select "div#6.food-name", text: "Tofu"
    assert_select "div#5.food-name", text: "Spinach"
    assert_select "div#7.food-name", text: "Orange"

    get "/recipes/search/Tofu?id=6"
    assert_select "div#4", text: "Mabo Tofu"
    assert_select "div#6", text: "Hiyayakko"
    assert_select "div#7", text: "Teriyaki tofu"
  end

end
