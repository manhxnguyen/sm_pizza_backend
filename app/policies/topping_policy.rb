class ToppingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # All authenticated users can view toppings (needed by pizza chefs to see available toppings)
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  # Only pizza store owners can manage toppings (create, update, delete)
  # Super admins have all permissions
  def create?
    user&.super_admin? || user&.pizza_store_owner?
  end

  def update?
    user&.super_admin? || user&.pizza_store_owner?
  end

  def destroy?
    user&.super_admin? || user&.pizza_store_owner?
  end
end
