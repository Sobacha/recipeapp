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
    @authorized_user = users(:one)
    @non_autho_user = users(:two)
    @recipe = recipes(:two)
  end

  test "User must log in to do actions." do
    # index
    get recipes_path
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."

    # show
    get recipe_path(@recipe)
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."

    # new
    get new_recipe_path
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."

    # create
    post recipes_path, params: { recipe: { category: "Tofu",
                                           title: "    ",
                                           ingredients: "Tofu, Onion, Salt, Pepper",
                                           direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                           url: "google.com",
                                           user_id: @authorized_user.id } }
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."

    # edit
    get edit_recipe_path(@recipe)
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."

    # update
    patch recipe_path(@recipe), params: { recipe: { category: @recipe.category,
                                                    title: "",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."

    # destroy
    delete recipe_path(@recipe)
    follow_redirect!
    assert_template 'home'
    assert_select "div.alert", text: "Please log in."
  end

  test "Non-Authorized user can't see other users' recipes." do
    get login_path
    post login_path, params: { session: { email: @non_autho_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @non_autho_user
    follow_redirect!
    assert_template 'users/show'

    get recipe_path(@recipe)
    follow_redirect!
    assert_template 'index'
    assert_select "div.alert", text: "You don't have that recipe!"
  end

  test "Invalid recipe - No title(Empty input)" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
                                             user_id: @authorized_user.id } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
    assert_select "ul.alert", text: "Title can't be blank"
  end

  test "Invalid recipe - No title(Only space input)" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
                                             user_id: @authorized_user.id } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
    assert_select "ul.alert", text: "Title can't be blank"
  end

  test "Invalid recipe - Title is too long" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
                                             user_id: @authorized_user.id } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
    assert_select "ul.alert", text: "Title is too long (maximum is 50 characters)"
  end

  test "Invalid recipe - Category is too long" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
                                             user_id: @authorized_user.id } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert", text: "1 error prohibited this recipe from being saved:"
    assert_select "ul.alert", text: "Category is too long (maximum is 50 characters)"
  end

  test "Invalid recipe - Category and title are too long" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get new_recipe_path
    # how to test text field is prefilled?
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: 'a'*51,
                                             title: 'b'*51,
                                             ingredients: @recipe.ingredients,
                                             direction: @recipe.direction,
                                             url: @recipe.url,
                                             user_id: @recipe.user_id } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert", text: "2 errors prohibited this recipe from being saved:"
    assert_select "ul.alert" do
      assert_select "li", 2
      # how to test actual msg is correct?
    end
  end

  test "Invalid recipe - Unauthorized user_id" do
    pass
    # user_id is hidden from user. need test?
  end

  test "Valid recipe" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
                                             user_id: @authorized_user.id } }
    end
    follow_redirect!
    assert_template 'show'
  end

  test "Non-Authorized user can't access edit url of other users' recipes." do
    get login_path
    post login_path, params: { session: { email: @non_autho_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @non_autho_user
    follow_redirect!
    assert_template 'users/show'

    get edit_recipe_path(@recipe)
    follow_redirect!
    assert_template 'index'
    assert_select "div.alert", text: "You don't have that recipe!"
  end

  # Is this necessary?
  test "Non-Authorized user can't patch other users' recipes." do
    get login_path
    post login_path, params: { session: { email: @non_autho_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @non_autho_user
    follow_redirect!
    assert_template 'users/show'

    patch recipe_path(@recipe), params: { recipe: { category: @recipe.category,
                                                    title: "",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    follow_redirect!
    assert_template 'index'
    assert_select "div.alert", text: "You don't have that recipe!"
  end

  test "Invalid edit recipe - No title(Empty input) - (from the list of recipes page)" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
    assert_select "ul.alert", text: "Title can't be blank"
  end

  test "Invalid edit recipe - No title(Only space input) - (from the recipe show page)" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
    assert_select "ul.alert", text: "Title can't be blank"
  end

  test "Invalid edit recipe - Title is too long" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
    assert_select "ul.alert", text: "Title is too long (maximum is 50 characters)"
  end

  test "Invalid edit recipe - Category is too long" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
    assert_select "ul.alert", text: "Category is too long (maximum is 50 characters)"
  end

  test "Invalid edit recipe - Category is too long and No title" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    get edit_recipe_path(@recipe)
    # how to test text field is prefilled?
    patch recipe_path(@recipe), params: { recipe: { category: 'a'*51,
                                                    title: "",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    assert_template 'edit'
    assert_select "div.alert", text: "2 errors prohibited this recipe from being saved:"
    assert_select "ul.alert" do
      assert_select "li", 2
      # how to test actual msg is correct?
    end
  end

  test "Valid edit recipe" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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

  test "Non-authorized user can't delete recipe - (from the list of recipes page)" do
    get login_path
    post login_path, params: { session: { email: @non_autho_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @non_autho_user
    follow_redirect!
    assert_template 'users/show'

    get recipes_path
    # how to test pop-up confirmation msg?
    assert_no_difference 'Recipe.count' do
      delete recipe_path(@recipe)
    end

    follow_redirect!
    assert_template 'index'
    assert_select "div.alert", text: "You don't have that recipe!"
  end

  test "Authorized user can delete recipe - (from the list of recipes page)" do
    get login_path
    post login_path, params: { session: { email: @authorized_user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @authorized_user
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
