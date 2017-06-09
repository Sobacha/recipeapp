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

end
