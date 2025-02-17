class OrderItemsController < ApplicationController

  def create
    current_cart = Cart.find_by(user_id: current_user.id)
    current_cart_items = current_cart.cart_products

    current_order = Order.create(user_id: current_user.id)

    current_cart_items.each do |cart_item|
      OrderItem.create(order_id: current_order.id, product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.product.price * cart_item.quantity )
      cart_item.destroy
    end

    redirect_to root_path, notice: "Order Placed!"
  end

  def update
    order_item = OrderItem.find_by(id: params[:id])
    if order_item.update(status: params[:status])
      redirect_to orders_user_path(current_user), notice: "Updated"
    end
  end
end