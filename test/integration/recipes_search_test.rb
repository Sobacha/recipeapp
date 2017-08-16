require 'test_helper'

class RecipesSearchTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:three)
    @food = foods(:six)
  end

  test "Find peoper recipes by food" do
    pass
  end
end
