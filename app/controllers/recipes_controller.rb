class RecipesController < ApplicationController
  helper FoodsHelper  # to use methods in controllers/helpers/foods_helper.rb
  before_action :logged_in_user
  before_action :correct_user, only:[:show, :edit, :update, :destroy, :search]

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
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
    @food = current_user.foods.find(params[:id])
    @recipes = current_user.recipes.where("ingredients like ?", "%#{@food.name}%")
  end


  private
    def recipe_params
      params.require(:recipe).permit(:category, :title, :ingredients, :direction, :url)
    end

    # Confirms the correct user.
    def correct_user
      begin
        @recipe = current_user.recipes.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:danger] = "You don't have that recipe!"
        redirect_to recipes_path
      end
    end

end
