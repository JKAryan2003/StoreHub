class MenuController < ApplicationController
  def index
    @products = Product.all
  end
end