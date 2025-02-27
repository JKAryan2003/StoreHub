class CartProductsController < ApplicationController
  before_action :create_cart

  def create

    product = Product.find_by(id: params[:id])

    if (product.check_product_stock == 0)
      flash[:alert] = 'Product out of stock'
    else
      cart_product = @cart.cart_products.find_by(product_id: product.id)

      if cart_product
        cart_product.update(quantity: cart_product.quantity + 1)
        flash[:notice] = 'Added to cart'
      else
        @cart.cart_products.create(product_id: product.id, quantity: 1)
        flash[:notice] = 'Added to cart'
      end
    end

    redirect_to products_path

  end

end