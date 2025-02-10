class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :new, :create, :destroy]

  def index
    @products = Product.all
    @product = Product.find_by(id: params[:id])
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
    @product = Product.find_by(id: params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find_by(id: params[:id])
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

  def search
    if params[:search].blank?
      redirect_to products_path
    else
      @parameter = params[:search].downcase
      @results = Product.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
    end
  end


  private

  def product_params
    params.require(:product).permit(:current_user, :name, :description, :price, :search, category_ids: [], images: [])
  end

  def product
    @product ||= Product.find_by(id: params[:id])
  end
end