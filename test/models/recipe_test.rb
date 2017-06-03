require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    # This code is not idiomatically correct.
    @recipe = Recipe.new(category: "Main",
                         title: "Mabo Tofu",
                         ingredients: "Tofu, Pork, Salt, Pepper, Starch",
                         direction: "1, Stir fry pork. 2, Put the rest of ingredients. 3, Simmer for 15 minutes.",
                         url: "google.com",
                         user_id: @user.id)
  end

  test "should be valid" do
    assert @recipe.valid?
  end

  test "title should be present (empty input)" do
    @recipe.title = ""
    assert_not @recipe.valid?
  end

  test "title should be present (only space input)" do
    @recipe.title = "    "
    assert_not @recipe.valid?
  end

  test "user id should be present" do
    @recipe.user_id = nil
    assert_not @recipe.valid?
  end

  test "user id should be existing user's" do
    @recipe.user_id = 100
    assert_not @recipe.valid?
  end

  test "category should not be more than 50" do
    @recipe.category = 'a' * 51
    assert_not @recipe.valid?
  end

  test "title should not be more than 50" do
    @recipe.title = 'a' * 51
    assert_not @recipe.valid?
  end

end
