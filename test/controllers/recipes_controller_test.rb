require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest

  test "recipes routings" do
    assert_routing({method: 'get', path: 'recipes'},
                   {controller: "recipes", action: "index"})
    assert_routing({method: 'get', path: 'recipes/1'},
                   {controller: "recipes", action: "show", id: "1"})
    assert_routing({method: 'get', path: 'recipes/new'},
                   {controller: "recipes", action: "new"})
    assert_routing({method: 'post', path: 'recipes'},
                   {controller: "recipes", action: "create"})
    assert_routing({method: 'get', path: 'recipes/1/edit'},
                   {controller: "recipes", action: "edit", id: "1"})
    assert_routing({method: 'patch', path: 'recipes/1'},
                   {controller: "recipes", action: "update", id: "1"})
    # assert_routing({method: 'put', path: 'recipes/1'},
    #                {controller: "recipes", action: "update", id: "1"})
    assert_routing({method: 'delete', path: 'recipes/1'},
                   {controller: "recipes", action: "destroy", id: "1"})
  end

  def setup
    @user = users(:one)
    @recipe = recipes(:two)
  end

  test "Invalid recipe - No title(Empty input)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: "",
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "google.com",
                                             user_id: @user.id } }
    end
    assert_template 'recipes/new'
  end

  test "Invalid recipe - No title(Only space input)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: "    ",
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "google.com",
                                             user_id: @user.id } }
    end
    assert_template 'recipes/new'
  end

  test "Invalid recipe - Title is too long" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: 'a'*51,
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "google.com",
                                             user_id: @user.id } }
    end
    assert_template 'recipes/new'
  end

  test "Invalid recipe - Category is too long" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: 'a'*51,
                                             title: "Fried rice",
                                             ingredients: "Cooked rice, Onion, Egg, Carrot, Salt, Pepper",
                                             direction: "1, Cut onion and carrot. 2, Stir fry. Add egg. 3, Put salt and pepper for taste.",
                                             url: "google.com",
                                             user_id: @user.id } }
    end
    assert_template 'recipes/new'
  end

  test "Valid recipe" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get new_recipe_path
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: "Tofu and onion",
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "google.com",
                                             user_id: @user.id } }
    end
    follow_redirect!
    assert_template 'show'
  end

  test "Invalid edit recipe - No title(Empty input) - (from the list of recipes page)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get edit_recipe_path(@recipe)
    # how to test text field is prefilled?
    patch recipe_path(@recipe), params: { recipe: { category: @recipe.category,
                                                    title: "",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
  end

  test "Invalid edit recipe - No title(Only space input) - (from the recipe show page)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get recipe_path(@recipe)
    get edit_recipe_path(@recipe)
    # how to test text field is prefilled?
    patch recipe_path(@recipe), params: { recipe: { category: @recipe.category,
                                                    title: "        ",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
  end

  test "Invalid edit recipe - Title is too long" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get edit_recipe_path(@recipe)
    # how to test text field is prefilled?
    patch recipe_path(@recipe), params: { recipe: { category: @recipe.category,
                                                    title: 'a'*51,
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
  end

  test "Invalid edit recipe - Category is too long" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get edit_recipe_path(@recipe)
    # how to test text field is prefilled?
    patch recipe_path(@recipe), params: { recipe: { category: 'a'*51,
                                                    title: @recipe.title,
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    assert_template 'edit'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
  end

  test "Valid edit recipe" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get edit_recipe_path(@recipe)
    # how to test text field is prefilled?
    patch recipe_path(@recipe), params: { recipe: { category: "Fruit salad",
                                                    title: "Fruit salad",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    # user_id is not passed when updated so no need to pass?
                                                    } }
    follow_redirect!
    assert_template 'show'
  end

  test "Delete recipe - (from the list of recipes page)" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    # how to test pop-up confirmation msg?
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end

    follow_redirect!
    assert_template 'index'
  end
end
