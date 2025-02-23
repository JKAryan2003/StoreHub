class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :show, :all_orders]

  def index
    @orders = Order.all
    authorize @orders
  end

  def show
    @orders = Order.where(user_id: current_user.id)
  end

  def all_orders
    @orders = Order.all
    authorize @orders
  end

end