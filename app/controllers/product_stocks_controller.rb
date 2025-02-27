class ProductStocksController < ApplicationController
  
  def new
    @product = Product.find(params[:product_id])
    @product_stock = ProductStock.new
  end

  def create
    @product_stock = ProductStock.new(stock_params)
    @product_stock.product = Product.find(stock_params[:product_id])

    if ( stock_params[:transaction_type] == "out") && (@product_stock.product.check_product_stock - stock_params[:quantity].to_i < 0)
      flash[:alert] = "Stock cannot be negative"
      redirect_to all_products_path
    else
      if @product_stock.save
        redirect_to root_path, notice: "Inventory Updated"
      else
        flash.now[:alert] = @product_stock.errors.full_messages.to_sentence
        render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
      end
    end
  
  end 

  private

  def stock_params
    params.require(:product_stock).permit(:transaction_type, :quantity, :product_id)
  end

end