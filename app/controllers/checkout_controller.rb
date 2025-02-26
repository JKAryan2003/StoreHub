class CheckoutController < ApplicationController
  
  def index 
    @cart = current_user.cart
    @addresses = current_user.addresses
    @cart_products = @cart.cart_products

    @total = 0 

    @cart_products.each do |cart_product|
      @total = @total + Product.find_by(id: cart_product.product_id).price * cart_product.quantity 
    end

    @order = Razorpay::Order.create amount: (@total*100).to_i, currency: 'INR', receipt: 'TEST' 
  end

end