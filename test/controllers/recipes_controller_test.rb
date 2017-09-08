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
    assert_routing({method: 'delete', path: 'recipes/1'},
                   {controller: "recipes", action: "destroy", id: "1"})
  end


  # Test for index
  test "user must log in to see recipe list" do
    get recipes_path
    follow_redirect!
    assert login_error_msg
  end

  # Test for show
  test "user must log in to see a recipe detail" do
    get recipe_path(@recipe)
    follow_redirect!
    assert login_error_msg
  end

  test "user can't see other users' recipes" do
    assert log_in(@non_autho_user)

    get recipe_path(@recipe)
    follow_redirect!
    assert unauthorized_data_error_msg("recipe")
  end

  # Test for create
  test "user must log in to create a recipe" do
    # new
    get new_recipe_path
    follow_redirect!
    assert login_error_msg

    # create
    post recipes_path, params: { recipe: { category: "Tofu",
                                           title: "    ",
                                           ingredients: "Tofu, Onion, Salt, Pepper",
                                           direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                           url: "https://www.example.com/",
                                           user_id: @authorized_user.id,
                                           recipe_image: "http://www.sirogohan.com/_files/recipe/images/agedasi/agedasiyoko.JPG" } }
    follow_redirect!
    assert login_error_msg
  end

  test "empty title mustn't be saved" do
    assert log_in(@authorized_user)

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: "",
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "https://www.example.com/",
                                             user_id: @authorized_user.id,
                                             recipe_image: "" } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Title can't be blank"
  end

  test "space-only title mustn't be saved" do
    assert log_in(@authorized_user)

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: "    ",
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "https://www.https://www.example.com//",
                                             user_id: @authorized_user.id,
                                             recipe_image: nil } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Title can't be blank"
  end

  test "too long title mustn't be saved" do
    assert log_in(@authorized_user)

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: 'a'*51,
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "https://www.example.com/",
                                             user_id: @authorized_user.id } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Title is too long (maximum is 50 characters)"
  end

  test "too long category mustn't be saved" do
    assert log_in(@authorized_user)

    get recipes_path
    get new_recipe_path
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { category: 'a'*51,
                                             title: "Fried rice",
                                             ingredients: "Cooked rice, Onion, Egg, Carrot, Salt, Pepper",
                                             direction: "1, Cut onion and carrot. 2, Stir fry. Add egg. 3, Put salt and pepper for taste.",
                                             url: "https://www.example.com/",
                                             user_id: @authorized_user.id } }
    end
    assert_template 'recipes/new'
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Category is too long (maximum is 50 characters)"
  end

  test "both title and category are too long to be saved" do
    assert log_in(@authorized_user)

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
    assert_select "div.alert div", text: "The form contains 2 errors."
    assert_select "div.alert ul li#0", text: "Category is too long (maximum is 50 characters)"
    assert_select "div.alert ul li#1", text: "Title is too long (maximum is 50 characters)"
  end

  # test "invalid url can't be saved" do
  #   assert log_in(@authorized_user)
  #
  #   get recipes_path
  #   get new_recipe_path
  #   assert_no_difference 'Recipe.count' do
  #     post recipes_path, params: { recipe: { category: "Tofu",
  #                                            title: "Tofu and onion",
  #                                            ingredients: "Tofu, Onion, Salt, Pepper",
  #                                            direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
  #                                            url: "https:www.example.com/",
  #                                            user_id: @authorized_user.id } }
  #   end
  #   assert_template 'recipes/new'
  #   assert_select "div.alert div", text: "The form contains 1 error."
  #   assert_select "div.alert ul li#0", text: "Url is not a valid URL"
  # end

  # test "invalid recipe_image can't be saved" do
  #   assert log_in(@authorized_user)
  #
  #   get recipes_path
  #   get new_recipe_path
  #   assert_no_difference 'Recipe.count' do
  #     post recipes_path, params: { recipe: { category: "Tofu",
  #                                            title: "Tofu and onion",
  #                                            ingredients: "Tofu, Onion, Salt, Pepper",
  #                                            direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
  #                                            url: "https://www.example.com/",
  #                                            recipe_image: "http://www.sirogohan.com/_files/recipe/images/agedasi/a gedasiyoko.JPG",
  #                                            user_id: @authorized_user.id } }
  #   end
  #   assert_template 'recipes/new'
  #   assert_select "div.alert div", text: "The form contains 1 error."
  #   assert_select "div.alert ul li#0", text: "Recipe_image is not a valid URL"
  # end

  # test "empty title/too long category/invalid url can't be saved" do
  #   assert log_in(@authorized_user)
  #
  #   get recipes_path
  #   get new_recipe_path
  #   assert_no_difference 'Recipe.count' do
  #     post recipes_path, params: { recipe: { category: 'a'*51,
  #                                            title: "",
  #                                            ingredients: "Tofu, Onion, Salt, Pepper",
  #                                            direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
  #                                            url: "www.example.com/",
  #                                            user_id: @authorized_user.id } }
  #   end
  #   assert_template 'recipes/new'
  #   assert_select "div.alert div", text: "The form contains 3 errors."
  #   assert_select "div.alert ul li#0", text: "Category is too long (maximum is 50 characters)"
  #   assert_select "div.alert ul li#1", text: "Title can't be blank"
  #   assert_select "div.alert ul li#2", text: "Url is not a valid URL"
  # end

  test "valid new recipe" do
    assert log_in(@authorized_user)

    get recipes_path
    get new_recipe_path
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { category: "Tofu",
                                             title: "Tofu and onion",
                                             ingredients: "Tofu, Onion, Salt, Pepper",
                                             direction: "1, Cut tofu and onion. 2, Stir fry. 3, Put salt and pepper for taste.",
                                             url: "https://www.example.com/",
                                             user_id: @authorized_user.id,
                                             recipe_image: "http://www.sirogohan.com/_files/recipe/images/agedasi/agedasiyoko.JPG" } }
    end
    follow_redirect!
    assert_template 'show'
  end

  # Test for edit
  test "user must log in to edit/update recipes" do
    # edit
    get edit_recipe_path(@recipe)
    follow_redirect!
    assert login_error_msg

    # update
    patch recipe_path(@recipe), params: { recipe: { category: @recipe.category,
                                                    title: "",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    follow_redirect!
    assert login_error_msg
  end

  test "user can't access edit_recipe_path for other users' recipes" do
    assert log_in(@non_autho_user)

    get edit_recipe_path(@recipe)
    follow_redirect!
    assert unauthorized_data_error_msg("recipe")
  end

  # Is this necessary?
  test "user can't send patch for other users' recipes" do
    assert log_in(@non_autho_user)

    patch recipe_path(@recipe), params: { recipe: { category: @recipe.category,
                                                    title: "",
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    follow_redirect!
    assert unauthorized_data_error_msg("recipe")
  end

  test "title mustn't be modified to empty - from the recipes index view" do
    assert log_in(@authorized_user)

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
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Title can't be blank"
  end

  test "title mustn't be modified to space-only - from the recipe show view" do
    assert log_in(@authorized_user)

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
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Title can't be blank"
  end

  test "title mustn't be modified to be too long" do
    assert log_in(@authorized_user)

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
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Title is too long (maximum is 50 characters)"
  end

  test "category mustn't be modified to be too long" do
    assert log_in(@authorized_user)

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
    assert_select "div.alert div", text: "The form contains 1 error."
    assert_select "div.alert ul li#0", text: "Category is too long (maximum is 50 characters)"
  end

  test "both title and category mustn't be modified to be too long" do
    assert log_in(@authorized_user)

    get recipes_path
    get edit_recipe_path(@recipe)
    # how to test text field is prefilled?
    patch recipe_path(@recipe), params: { recipe: { category: 'a'*51,
                                                    title: 'b'*55,
                                                    ingredients: @recipe.ingredients,
                                                    direction: @recipe.direction,
                                                    url: @recipe.url,
                                                    user_id: @recipe.user_id } }
    assert_template 'edit'
    assert_select "div.alert div", text: "The form contains 2 errors."
    assert_select "div.alert ul li#0", text: "Category is too long (maximum is 50 characters)"
    assert_select "div.alert ul li#1", text: "Title is too long (maximum is 50 characters)"
  end

  # test "url can't be modified to invalid url" do
  #   assert log_in(@authorized_user)
  #
  #   get recipes_path
  #   get edit_recipe_path(@recipe)
  #   # how to test text field is prefilled?
  #   patch recipe_path(@recipe), params: { recipe: { category: 'a'*50,
  #                                                   title: 'b'*50,
  #                                                   ingredients: @recipe.ingredients,
  #                                                   direction: @recipe.direction,
  #                                                   url: "example.com/ home.html",
  #                                                   user_id: @recipe.user_id } }
  #   assert_template 'edit'
  #   assert_select "div.alert div", text: "The form contains 1 error."
  #   assert_select "div.alert ul li#0", text: "Url is not a valid URL"
  # end

  test "valid edit recipe" do
    assert log_in(@authorized_user)

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

  # Test for destroy
  test "user must log in to delete a recipe" do
    delete recipe_path(@recipe)
    follow_redirect!
    assert login_error_msg
  end

  test "user can't delete other users' recipe - from the recipe index view" do
    assert log_in(@non_autho_user)

    get recipes_path
    # how to test pop-up confirmation msg?
    assert_no_difference 'Recipe.count' do
      delete recipe_path(@recipe)
    end

    follow_redirect!
    assert unauthorized_data_error_msg("recipe")
  end

  test "valid delete - from the recipes index view" do
    assert log_in(@authorized_user)

    get recipes_path
    # how to test pop-up confirmation msg?
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end

    follow_redirect!
    assert_template 'index'
  end
end
