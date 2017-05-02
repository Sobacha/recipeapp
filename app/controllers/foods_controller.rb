class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  #def show
  #  @food = Food.find(params[:id])
  #end

  def new
    @food = Food.new
  end

  def edit
    @food = Food.find(params[:id])
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  def update
    @food = Food.find(params[:id])

    if @food.update(food_params)
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_path
  end

  private
    def food_params
      params.require(:food).permit(:category, :name, :purchase_date, :expiration_date, :quantity)
    end

end
