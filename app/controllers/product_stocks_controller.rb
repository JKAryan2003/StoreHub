class ProductStocksController < ApplicationController
  def new
    @stock = ProductStock.new
  end

  def create
    @stock = ProductStock.new(stock_params)
    @stock.product = Product.find_by(id: params[:id])

    if transaction_type == true
    end

    if @product.save
      redirect_to products_path, notice: "Product added"
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end

  end

  private

  def stock_params
    params.require(:stock).permit(:transaction_type, :quantity)
  end


end