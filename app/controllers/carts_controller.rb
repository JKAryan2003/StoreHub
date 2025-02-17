class CartsController < ApplicationController

  def increase
    cart_product = CartProduct.find_by(id: params[:id])
    if cart_product
      cart_product.update(quantity: cart_product.quantity + 1)
      redirect_to cart_user_path(current_user), notice: "Quantity increased"
    end
  end

  def decrease
    cart_product = CartProduct.find_by(id: params[:id])
    if cart_product
      if cart_product.quantity > 0
        cart_product.update(quantity: cart_product.quantity - 1)
        redirect_to cart_user_path(current_user), notice: "Quantity decreased"
      end
    end
  end

  def show
    @cart = current_user.cart
    
    @cart_products = @cart.cart_products

    @total = 0 

    @cart_products.each do |cart_product|
      @total = @total + Product.find_by(id: cart_product.product_id).price * cart_product.quantity 
    end
  end

  def destroy
    cart_product = CartProduct.find_by(id: params[:id])
    cart_product.destroy
    redirect_to cart_user_path(current_user), notice: "Product removed"
  end

end
