class Pizza < ApplicationRecord
  # Associations
  has_many :pizza_toppings, dependent: :destroy
  has_many :toppings, through: :pizza_toppings

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 500 }

  # Scopes
  scope :ordered_by_name, -> { order(:name) }
  scope :with_toppings, -> { joins(:toppings).distinct }

  # Instance methods
  def total_price
    toppings.sum(:price)
  end

  def topping_names
    toppings.pluck(:name).join(", ")
  end

  def add_topping(topping)
    toppings << topping unless toppings.include?(topping)
  end

  def remove_topping(topping)
    toppings.delete(topping)
  end
end
