require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    # This code is not idiomatically correct.
    @recipe = Recipe.new(category: "Main",
                         title: "Test",
                         ingredients: "test, test",
                         direction: "1, 2, ",
                         url: "",
                         user_id: @user.id)
  end

  test "should be valid" do
    assert @recipe.valid?
  end

  test "user id should be present" do
    @recipe.user = nil
    assert_not @recipe.valid?
  end
end
