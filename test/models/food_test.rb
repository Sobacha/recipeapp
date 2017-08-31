require 'test_helper'

class FoodTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    # This code is not idiomatically correct.
    @food = Food.new(category: "Fruit",
                     name: "Mikan",
                     purchase_date: 2017-05-01,
                     expiration_date: 2017-06-01,
                     quantity: 10,
                     user_id: @user.id)
  end

  test "should be valid" do
    assert @food.valid?
  end

  test "name should be present (empty input)" do
    @food.name = ""
    assert_not @food.valid?
  end

  test "name should be present (only space input)" do
    @food.name = "    "
    assert_not @food.valid?
  end

  test "user id should be present" do
    @food.user_id = nil
    assert_not @food.valid?
  end

  test "user id should be existing user's" do
    @food.user_id = 100
    assert_not @food.valid?
  end

  # test "category should not be more than 50" do
  #   @food.category = 'a' * 51
  #   assert_not @food.valid?
  # end

  test "name should not be more than 50" do
    @food.name = 'a' * 51
    assert_not @food.valid?
  end

end
