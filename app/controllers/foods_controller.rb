class FoodsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only:[:edit, :update, :destroy]

  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    if @food.save
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  def update
    @food = current_user.foods.find(params[:id])

    if @food.update(food_params)
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy

    redirect_to foods_path
  end

  private
    def food_params
      params.require(:food).permit(:category, :name, :purchase_date, :expiration_date, :quantity)
    end

    # Confirms the correct user.
    def correct_user
      begin
        @food = current_user.foods.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:danger] = "You don't have that food!"
        redirect_to foods_path
      end
    end
end
