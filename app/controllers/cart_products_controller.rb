class CartProductsController < ApplicationController
  before_action :create_cart

  def create

    product = Product.find_by(id: params[:id])
    cart_product = @cart.cart_products.find_by(product_id: product.id)

    if cart_product
      cart_product.update(quantity: cart_product.quantity + 1)
      flash[:notice] = 'Added to cart'
    else
      @cart.cart_products.create(product_id: product.id, quantity: 1)
      flash[:notice] = 'Added to cart'
    end

    redirect_to products_path

  end

  private

  def create_cart
    if user_signed_in?
      @cart ||= Cart.find_by(user_id: current_user.id)
      
      if @cart.nil?
        @cart = Cart.create(user_id: current_user.id) 
        session[:cart_id] = @cart.id 
      end
    else
      @cart ||= Cart.find_by(id: session[:cart_id]) 
      if @cart.nil?
        @cart = Cart.create 
        session[:cart_id] = @cart.id 
      end
    end
  end  
end