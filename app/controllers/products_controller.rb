class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :all_products]

  def index
   
    if params[:search]
      @products = Product.all
      @categories = Category.all
      @products = @products.where('name LIKE ?', "%#{params[:search]}%")
      
    elsif params[:category_id]
  
      @categories = Category.all
      category = Category.find_by(id: params[:category_id])
      @products = category.products

    else
      @products = Product.all
      @categories = Category.all
    end

  end

  def new
    @product = Product.new
    authorize @product
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    @product.user = current_user

    if @product.save
      redirect_to products_path, notice: "Product added"
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end
  end

  def edit
    product
    @categories = Category.all
  end

  def update
    product
    @categories = Category.all
    if @product.update(product_params)
      redirect_to products_path, notice: "Product is Updated"
    else
      render :edit
    end 
  end

  def show
    product
  end

  def destroy
    product.destroy
    redirect_to products_path
  end

  def all_products
    @all_products = Product.all
    authorize @all_products
  end

  private

  def product_params
    params.require(:product).permit(:current_user, :name, :description, :price, :search, category_ids: [], images: [])
  end

  def product
    @product ||= Product.find_by(id: params[:id])
  end
end