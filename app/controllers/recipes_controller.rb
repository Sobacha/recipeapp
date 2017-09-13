class RecipesController < ApplicationController
  helper FoodsHelper  # to use methods in controllers/helpers/foods_helper.rb
  before_action :logged_in_user
  before_action :correct_user, only:[:show, :edit, :update, :destroy]

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
    @foods = current_user.foods.all
    @ingredients = @recipe.ingredients.split("\n")
    @ingredients_you_have = Array.new

    @ingredients.each do |ingredient|
      @foods.each do |food|
        if ingredient.downcase.include?(food.name.downcase)
          @ingredients_you_have.push(ingredient)
        end
      end
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def update
    @recipe = current_user.recipes.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

  def search
    begin
      @food = current_user.foods.find(params[:id])
      @recipes = current_user.recipes.where("ingredients like ?", "%#{@food.name}%")
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "You don't have that food!"
      redirect_to foods_path
    end
  end


  private
    def recipe_params
      params.require(:recipe).permit(:category, :title, :ingredients, :direction, :url, :recipe_image)
    end

    # Confirms the correct user, shows nice error page if not
    def correct_user
      begin
        @recipe = current_user.recipes.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:danger] = "You don't have that recipe!"
        redirect_to recipes_path
      end
    end

end
