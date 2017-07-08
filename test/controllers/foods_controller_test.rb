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
    # assert_routing({method: 'put', path: 'foods/1'},
    #                {controller: "foods", action: "update", id: "1"})
    assert_routing({method: 'delete', path: 'foods/1'},
                   {controller: "foods", action: "destroy", id: "1"})
  end

  def setup
    @user = users(:one)
    @food = foods(:two)
  end

  # Test for create
  test "Invalid food - No name(Empty input)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish",
                                         name: "",
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1,
                                         user_id: @user.id } }
    end
    assert_template 'foods/new'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Name can't be blank"
  end

  test "Invalid food - No name(Only space input)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish",
                                         name: "             ",
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1,
                                         user_id: @user.id } }
    end
    assert_template 'foods/new'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Name can't be blank"
  end

  test "Invalid food - Too long name" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish",
                                         name: 'a'*55,
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1,
                                         user_id: @user.id } }
    end
    assert_template 'foods/new'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Name is too long (maximum is 50 characters)"
  end

  test "Invalid food - Too long category" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish"*55,
                                         name: "Salmon",
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1,
                                         user_id: @user.id } }
    end
    assert_template 'foods/new'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Category is too long (maximum is 50 characters)"
  end

  test "Invalid food - Unauthorized user_id" do
    pass
    # user_id is hidden from user. need test?
  end

  test "Invalid food - Too long category and name" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get new_food_path
    assert_no_difference 'Food.count' do
      post foods_path, params: { food: { category: "Fish"*55,
                                         name: "Salmon"*55,
                                         purchase_date: 2017-05-01,
                                         expiration_date: 2017-05-01,
                                         quantity: 1 } }
    end
    assert_template 'foods/new'
    assert_select "div.alert", text: "2 errors prohibited this food from being saved:"
    assert_select "ul.alert" do
      assert_select "li", 2
      # how to test actual msg is correct?
    end
  end

  test "Valid food" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

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
  test "Invalid edit food - No name(Empty input) - (from the list of foods page)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: @food.category,
                                              name: "",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1,
                                              user_id: @food.user_id
                                               } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Name can't be blank"
  end

  test "Invalid edit food - No name(Only space input) - (from the food show page)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: @food.category,
                                              name: "        ",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1,
                                              user_id: @food.user_id
                                              } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Name can't be blank"
  end

  test "Invalid edit food - name is too long" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: @food.category,
                                              name: 'a'*51,
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1,
                                              user_id: @food.user_id
                                              } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Name is too long (maximum is 50 characters)"
  end

  test "Invalid edit food - Category is too long" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: 'a'*51,
                                              name: @food.name,
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1,
                                              user_id: @food.user_id
                                              } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    assert_select "ul.alert", text: "Category is too long (maximum is 50 characters)"
  end

  test "Invalid edit food - Category is too long and No name" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: 'a'*51,
                                              name: "",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1,
                                              user_id: @food.user_id
                                              } }
    assert_template 'edit'
    assert_select "div.alert", text: "2 errors prohibited this food from being saved:"
    assert_select "ul.alert" do
      assert_select "li", 2
      # how to test actual msg is correct?
    end
  end

  test "Valid edit food" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    get edit_food_path(@food)
    # how to test text field is prefilled?
    patch food_path(@food), params: { food: { category: "Fruit salad",
                                              name: "Fruit salad",
                                              purchase_date: 2017-05-01,
                                              expiration_date: 2017-05-01,
                                              quantity: 1
                                              # user_id is not passed when updated so no need to pass?
                                                    } }
    follow_redirect!
    assert_template 'index'
  end

  test "Delete food - (from the list of foods page)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get foods_path
    # how to test pop-up confirmation msg?
    assert_difference 'Food.count', -1 do
      delete food_path(@food)
    end

    follow_redirect!
    assert_template 'index'
  end
end
