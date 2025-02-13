class CartController < ApplicationController

  def add
    product = Product.find_by(id: params[:id])
    if !current_user.cart
      @cart = Cart.new(user: current_user)
      if @cart.save
        flash[:notice] = 'Added to cart'
      else
        flash[:alert] = 'There was an issue creating the cart.'
        redirect_to root_path
        return
      end
    else
      @cart = current_user.cart
    end

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
      cart_product.update(quantity: cart_product.quantity - 1)
      redirect_to cart_user_path(current_user), notice: "Quantity decreased"
    end
  end


  def show
    if current_user.cart.blank?
    else
      @cart = current_user.cart
      @cart_products = @cart.cart_products
    end

    @total = 0 

    @cart_products.each do |cart_product|
      @total = @total + Product.find_by(id: cart_product.product_id).price * cart_product.quantity 
    end
        
  
  end

end
