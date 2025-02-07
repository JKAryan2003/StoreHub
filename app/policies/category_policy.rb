class CategoryPolicy < ApplicationPolicy
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
end