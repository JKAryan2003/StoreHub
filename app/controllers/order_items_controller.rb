class OrderItemsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    if Razorpay::Utility.verify_payment_signature(payment_signature)
      current_cart = Cart.find_by(user_id: current_user.id)
      current_cart_items = current_cart.cart_products
  
      current_order = Order.create(user_id: current_user.id, address_id: params[:id])
  
      current_cart_items.each do |cart_item|
        OrderItem.create(order_id: current_order.id, product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.product.price * cart_item.quantity )
        cart_item.destroy

        ProductStock.create(product_id: cart_item.product_id, transaction_type: "out", quantity: cart_item.quantity)
      end
      redirect_to root_path, notice: "Order Placed!"
    end
   
  end

  def update
    order_item = OrderItem.find_by(id: params[:id])

    if order_item.update(status: params[:status])
      if params[:status] == "cancelled"
        OrderMailer.order_cancel_mail(current_user).deliver_later
      end  
      redirect_to root_path
    end

  end

  private
  
  def payment_signature

    payment_response = {
      razorpay_order_id: params[:razorpay_order_id],
      razorpay_payment_id: params[:razorpay_payment_id],
      razorpay_signature: params[:razorpay_signature]
    }

  end
end