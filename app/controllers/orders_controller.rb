class OrdersController < ApplicationController

  def index
    current_owner = User.find_by(id: params[:id])
    @my_product_orders = current_owner.products
  end

  def show
    @my_orders = Order.where(user_id: current_user.id)
  end

end