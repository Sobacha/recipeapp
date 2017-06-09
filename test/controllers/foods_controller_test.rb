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

end
