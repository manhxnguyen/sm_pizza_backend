class PizzaPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # All authenticated users can view pizzas
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  # Pizza chefs, pizza store owners, and super admins can manage pizzas
  def create?
    user&.super_admin? || user&.pizza_store_owner? || user&.pizza_chef?
  end

  def update?
    user&.super_admin? || user&.pizza_store_owner? || user&.pizza_chef?
  end

  def destroy?
    user&.super_admin? || user&.pizza_store_owner? || user&.pizza_chef?
  end

  # Pizza chefs can add/remove toppings to existing pizzas
  def add_topping?
    user&.super_admin? || user&.pizza_store_owner? || user&.pizza_chef?
  end

  def remove_topping?
    user&.super_admin? || user&.pizza_store_owner? || user&.pizza_chef?
  end
end
