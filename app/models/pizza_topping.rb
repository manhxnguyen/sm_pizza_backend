class PizzaTopping < ApplicationRecord
  # Associations
  belongs_to :pizza
  belongs_to :topping

  # Validations
  validates :pizza_id, uniqueness: { scope: :topping_id }
end
