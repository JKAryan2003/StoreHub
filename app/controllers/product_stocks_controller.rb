class ProductStocksController < ApplicationController

  def index
  end

  
  def new
    @product = Product.find(params[:product_id])
    @product_stock = ProductStock.new
  end

  def create
    @product_stock = ProductStock.new(stock_params)
    @product_stock.product = Product.find(params[:product_id])

    if @product_stock.save
      redirect_to products_path, notice: "Product added"
    else
      flash.now[:alert] = @product_stock.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end
  end

  private

  def stock_params
    params.require(:product_stock).permit(:transaction_type, :quantity)
  end


end