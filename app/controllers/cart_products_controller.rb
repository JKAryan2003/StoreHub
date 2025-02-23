class CartProductsController < ApplicationController
  before_action :create_cart

  def new

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

end