class PizzaSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :total_price, :topping_names, :created_at, :updated_at

  has_many :toppings, serializer: :topping
end
