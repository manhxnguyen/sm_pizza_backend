class Topping < ApplicationRecord
  # Associations
  has_many :pizza_toppings, dependent: :destroy
  has_many :pizzas, through: :pizza_toppings

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: { greater_than: 0 }

  # Scopes
  scope :ordered_by_name, -> { order(:name) }
  scope :by_price_range, ->(min, max) { where(price: min..max) }

  # Instance methods
  def formatted_price
    "$#{'%.2f' % price}"
  end
end
