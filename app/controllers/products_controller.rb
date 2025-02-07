class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    authorize @product
    @categories = Category.all
  end

  def create
    authorize current_user
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to products_path, notice: "Product added"
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "Product is Updated"
    else
      render :edit
    end 
  end

  private

  def product_params
    params.require(:product).permit(:current_user, :name, :description, :price, :category_ids, images: [])
  end
end