class CartsController < ApplicationController
  before_action :create_cart

  def index
    @cart_products = @cart.cart_products

    @total = 0 

    @cart_products.each do |cart_product|
      @total = @total + Product.find_by(id: cart_product.product_id).price * cart_product.quantity 
    end
  end

  def increase
    cart_product = CartProduct.find_by(id: params[:id])
    if cart_product
      cart_product.update(quantity: cart_product.quantity + 1)
      redirect_to carts_path, notice: "Quantity increased"
    end
  end

  def decrease
    cart_product = CartProduct.find_by(id: params[:id])
    if cart_product
      if cart_product.quantity > 1
        cart_product.update(quantity: cart_product.quantity - 1)
        redirect_to carts_path, notice: "Quantity decreased"
      else
        cart_product.destroy
        redirect_to carts_path
      end
    end
  end

  def destroy
    cart_product = CartProduct.find_by(id: params[:id])
    cart_product.destroy
    redirect_to cart_user_path(current_user), notice: "Product removed"
  end

end
