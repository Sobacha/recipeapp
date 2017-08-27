module FoodsHelper

  def possible_recipe(food)
    @recipes = current_user.recipes.where("ingredients like ?", "%#{food.name}%")

    if @recipes.empty?
      return false
    else
      return @recipes
    end

  end

end
