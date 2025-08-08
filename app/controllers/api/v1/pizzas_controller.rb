class Api::V1::PizzasController < Api::V1::BaseController
  before_action :set_pizza, only: [ :show, :update, :destroy, :add_topping, :remove_topping ]

  def index
    authorize Pizza
    pizzas = Pizza.includes(:toppings).ordered_by_name
    result = paginate_collection(pizzas)

    render json: PizzaSerializer.new(result[:data], {
      meta: result[:meta],
      include: [ :toppings ]
    }).serializable_hash
  end

  def show
    authorize @pizza
    render json: PizzaSerializer.new(@pizza, {
      include: [ :toppings ]
    }).serializable_hash
  end

  def create
    authorize Pizza
    pizza = Pizza.new(pizza_params)

    if pizza.save
      handle_toppings(pizza) if params[:pizza][:topping_ids].present?
      pizza.reload
      render json: PizzaSerializer.new(pizza, {
        include: [ :toppings ]
      }).serializable_hash, status: :created
    else
      render json: {
        error: "Validation failed",
        details: pizza.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    authorize @pizza
    if @pizza.update(pizza_params)
      handle_toppings(@pizza) if params[:pizza][:topping_ids].present?
      @pizza.reload
      render json: PizzaSerializer.new(@pizza, {
        include: [ :toppings ]
      }).serializable_hash
    else
      render json: {
        error: "Validation failed",
        details: @pizza.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @pizza
    @pizza.destroy
    head :no_content
  end

  def add_topping
    authorize @pizza, :add_topping?
    topping = Topping.find(params[:topping_id])

    if @pizza.toppings.include?(topping)
      render json: {
        error: "Topping already exists",
        message: "This topping is already on the pizza"
      }, status: :unprocessable_entity
    else
      @pizza.add_topping(topping)
      render json: PizzaSerializer.new(@pizza, {
        include: [ :toppings ]
      }).serializable_hash
    end
  end

  def remove_topping
    authorize @pizza, :remove_topping?
    topping = Topping.find(params[:topping_id])
    @pizza.remove_topping(topping)
    render json: PizzaSerializer.new(@pizza, {
      include: [ :toppings ]
    }).serializable_hash
  end

  private

  def set_pizza
    @pizza = Pizza.includes(:toppings).find(params[:id])
  end

  def pizza_params
    params.require(:pizza).permit(:name, :description)
  end

  def handle_toppings(pizza)
    # Access topping_ids from the nested pizza params
    topping_ids = params[:pizza][:topping_ids]
    return unless topping_ids.present?

    topping_ids = topping_ids.reject(&:blank?).map(&:to_i)
    toppings = Topping.where(id: topping_ids)
    pizza.toppings = toppings
  end
end
