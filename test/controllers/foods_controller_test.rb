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
    # get login_path
    # post login_path, params: { session: { email: @user.email,
    #                                       password: 'password' } }
    # assert is_logged_in?
    # assert_redirected_to @user
    # follow_redirect!
    # assert_template 'users/show'
    #
    # get foods_path
    # get new_food_path
    # assert_no_difference 'Food.count' do
    #   post foods_path, params: { food: { category: "Fish",
    #                                      name: "Salmon",
    #                                      purchase_date: 2017-05-01,
    #                                      expiration_date: 2017-05-01,
    #                                      quantity: 1 } }
    # end
    # assert_template 'foods/new'
    # assert_select "div.alert", text: "1 error prohibited this food from being saved:"
    # assert_select "ul.alert", text: "Category is too long (maximum is 50 characters)"
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
end
