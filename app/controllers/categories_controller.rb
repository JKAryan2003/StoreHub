class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
    @parent_categories = Category.where(parent_id: nil)
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

  def show
    category
  end
  def edit
    @category = Category.find_by(id: params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category is Updated"
    else
      render :edit
    end 
  end

  def destroy
    category.destroy
    redirect_to categories_path
  end

  def products
    @categories = Category.all
    category = Category.find_by(id: params[:id])
    @products = category.products
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :parent_id)
  end

  def category
    @category ||= Category.find_by(id: params[:id])
  end
end
