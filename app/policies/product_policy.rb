class ProductPolicy < ApplicationPolicy
  def new?
    user.owner? || user.admin?
  end

  def create?
    new?
  end

  def edit?
    user.owner?
  end

  def update?
    edit?
  end

  def all_products?
    user.admin?
  end
end