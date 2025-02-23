class CategoryPolicy < ApplicationPolicy
  
  def index?
    user.admin?
  end

  def new?
    user.admin?
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