class MenuController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all

    if params[:search].present?
      @products = @products.where('name LIKE ?', "%#{params[:search]}%")
    end
  end
end