class ToppingSerializer
  include JSONAPI::Serializer

  attributes :name, :price, :formatted_price, :created_at, :updated_at

  has_many :pizzas, serializer: :pizza
end
