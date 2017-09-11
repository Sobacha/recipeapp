require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

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

  test "url should be valid" do
    @recipe.url = "example.com"
    assert_not @recipe.valid?

    @recipe.url = "www.example.com"
    assert_not @recipe.valid?

    @recipe.url = "http:www.example.com"
    assert_not @recipe.valid?

    @recipe.url = "https:www.example.com"
    assert_not @recipe.valid?

    @recipe.url = "http://www.example.com"
    assert @recipe.valid?

    @recipe.url = "https://www.example.com"
    assert @recipe.valid?

    @recipe.url = "ftp://www.example.com"
    assert_not @recipe.valid?
  end

  test "recipe_image should be valid" do
    @recipe.recipe_image = "example.com"
    assert_not @recipe.valid?

    @recipe.recipe_image = "www.example.com"
    assert_not @recipe.valid?

    @recipe.recipe_image = "http:www.example.com"
    assert_not @recipe.valid?

    @recipe.recipe_image = "https:www.example.com"
    assert_not @recipe.valid?

    @recipe.recipe_image = "http://www.example.com"
    assert @recipe.valid?

    @recipe.recipe_image = "https://www.example.com"
    assert @recipe.valid?

    @recipe.recipe_image = "ftp://www.example.com"
    assert_not @recipe.valid?
  end

end
