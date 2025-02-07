class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit]

  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
    authorize @category
  end

  def create 
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "New Category Created"
    else
      flash.now[:alert] = @category.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end
  end

  def edit
  end

  def update
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
