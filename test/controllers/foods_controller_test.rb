require 'test_helper'

class FoodsControllerTest < ActionDispatch::IntegrationTest

  test "foods routings" do
    assert_routing({method: 'get', path: 'foods'},
                   {controller: "foods", action: "index"})
    assert_routing({method: 'get', path: 'foods/new'},
                   {controller: "foods", action: "new"})
    assert_routing({method: 'post', path: 'foods'},
                   {controller: "foods", action: "create"})
    assert_routing({method: 'get', path: 'foods/1/edit'},
                   {controller: "foods", action: "edit", id: "1"})
    assert_routing({method: 'patch', path: 'foods/1'},
                   {controller: "foods", action: "update", id: "1"})
    assert_routing({method: 'delete', path: 'foods/1'},
                   {controller: "foods", action: "destroy", id: "1"})
  end


  # Test for index
  test "user must log in to see food list." do
    get foods_path
    follow_redirect!
    assert login_error_msg
  end

  # Test for create
  test "user must log in to create new food" do
    # prevent accessing new_food_path
    get new_food_path
    follow_redirect!
    assert login_error_msg

    # prevent sending post directly
    post foods_path, params: { food: { category: "Fish",
                                       name: "Tuna",
                                       purchase_date: 2017-05-01,
                                       expiration_date: 2017-05-01,
                                       quantity: 1 } }
    follow_redirect!
    assert login_error_msg
  end

  test "empty name mustn't be saved" do
    assert log_in(@authorized_user)

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish",
                                         name: "",
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1 } }
    end
    assert_template 'foods/new'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li", text: "Name can't be blank"
  end

  test "space-only name mustn't be saved" do
    assert log_in(@authorized_user)

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish",
                                         name: "             ",
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1 } }
    end
    assert_template 'foods/new'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li", text: "Name can't be blank"
  end

  test "too long name mustn't be saved" do
    assert log_in(@authorized_user)

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish",
                                         name: 'a'*55,
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1 } }
    end
    assert_template 'foods/new'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li", text: "Name is too long (maximum is 50 characters)"
  end

  # test "too long category mustn't be saved" do
  #   assert log_in(@authorized_user)
  #
  #   get foods_path
  #   get new_food_path
  #   assert_no_difference 'Food.count' do
  #     post foods_path, params: { food: { category: "Fish"*55,
  #                                        name: "Salmon",
  #                                        purchase_date: 2017-05-01,
  #                                        expiration_date: 2017-05-01,
  #                                        quantity: 1 } }
  #   end
  #   assert_template 'foods/new'
  #   assert_select "div.alert", text: "The form contains 1 error."
  #   assert_select "div.alert ul li", text: "Category is too long (maximum is 50 characters)"
  # end

  # test "both name and category are too long to be saved" do
  #   assert log_in(@authorized_user)
  #
  #   get foods_path
  #   get new_food_path
  #   assert_no_difference 'Food.count' do
  #     post foods_path, params: { food: { category: "Fish"*55,
  #                                        name: "Salmon"*55,
  #                                        purchase_date: 2017-05-01,
  #                                        expiration_date: 2017-05-01,
  #                                        quantity: 1 } }
  #   end
  #   assert_template 'foods/new'
  #   assert_select "div.alert", text: "The form contains 2 errors."
  #   assert_select "div.alert ul li" do
  #     assert_select "li", 2
  #     # how to test actual msg is correct?
  #   end
  # end

  test "valid new food" do
    assert log_in(@authorized_user)

    get foods_path
    get new_food_path
    assert_difference 'Food.count', 1 do
      post foods_path, params: { food: { category: "Fish",
                                         name: "Tuna",
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1 } }
    end
    follow_redirect!
    assert_template 'index'
  end

  # Test for edit
  test "user must log in to edit" do
    # prevent accessing edit_food_path
    get edit_food_path(@food)
    follow_redirect!
    assert login_error_msg

    # prevent sending patch directly
    patch food_path(@food), params: { food: { category: "Fish",
                                              name: "Tuna",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1 } }
    follow_redirect!
    assert login_error_msg
  end

  test "user can't access edit_food_path of other users' food" do
    assert log_in(@unauthorized_user)

    get foods_path
    get edit_food_path(@food)
    follow_redirect!

    assert unauthorized_data_error_msg("food")
  end

  test "user can't send patch for other users' food" do
    assert log_in(@unauthorized_user)

    patch food_path(@food), params: { food: { category: @food.category,
                                              name: "Berry",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1 } }
    follow_redirect!
    assert unauthorized_data_error_msg("food")
  end

  test "name mustn't be modified to empty - from the food index view" do
    assert log_in(@authorized_user)

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: @food.category,
                                              name: "",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1 } }
    assert_template 'edit'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li", text: "Name can't be blank"
  end

  test "name mustn't be modified to only-space - from the food show view" do
    assert log_in(@authorized_user)

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: @food.category,
                                              name: "        ",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1 } }
    assert_template 'edit'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li", text: "Name can't be blank"

  end

  test "name mustn't be modified to be too long" do
    assert log_in(@authorized_user)

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: @food.category,
                                              name: 'a'*51,
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1 } }
    assert_template 'edit'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li", text: "Name is too long (maximum is 50 characters)"
  end

  # test "category mustn't be modified to be too long" do
  #   assert log_in(@authorized_user)
  #
  #   get foods_path
  #   get edit_food_path(@food)
  #   # how to test text field is prefilled?
  #   patch food_path(@food), params: { food: { category: 'a'*51,
  #                                             name: @food.name,
  #                                             purchase_date: 2017-05-01,
  #                                             expiration_date: 2017-05-01,
  #                                             quantity: 1 } }
  #   assert_template 'edit'
  #   assert_select "div.alert", text: "The form contains 1 error."
  #   assert_select "div.alert ul li", text: "Category is too long (maximum is 50 characters)"
  # end
  #
  # test "name mustn't be modified to empty and category mustn't be modified to be too long" do
  #   assert log_in(@authorized_user)
  #
  #   get foods_path
  #   get edit_food_path(@food)
  #   # how to test text field is prefilled?
  #   patch food_path(@food), params: { food: { category: 'a'*51,
  #                                             name: "",
  #                                             purchase_date: 2017-05-01,
  #                                             expiration_date: 2017-05-01,
  #                                             quantity: 1 } }
  #   assert_template 'edit'
  #   assert_select "div.alert", text: "The form contains 2 errors."
  #   assert_select "div.alert ul li" do
  #     assert_select "li", 2
  #     # how to test actual msg is correct?
  #   end
  # end

  test "valid edit food" do
    assert log_in(@authorized_user)

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: "Fruit salad",
                                              name: "Fruit salad",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1 } }
    follow_redirect!
    assert_template 'index'
  end

  # Test for destroy
  test "user must log in to delete food" do
    # destroy
    delete food_path(@food)
    follow_redirect!
    assert login_error_msg
  end

  test "user can't delete other users' food" do
    assert log_in(@unauthorized_user)

    assert_no_difference 'Food.count' do
      delete food_path(@food)
    end

    follow_redirect!
    assert unauthorized_data_error_msg("food")
  end

  test "valid delete - from the food index view" do
    assert log_in(@authorized_user)

    get foods_path
    # how to test pop-up confirmation msg?
    assert_difference 'Food.count', -1 do
      delete food_path(@food)
    end

    follow_redirect!
    assert_template 'index'
  end
end
