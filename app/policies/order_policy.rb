class OrderPolicy < ApplicationPolicy
  
  def index?
    user.owner?
  end

  # def show
  #   current_user?
  # end

  def all_orders?
    user.admin?
  end
end