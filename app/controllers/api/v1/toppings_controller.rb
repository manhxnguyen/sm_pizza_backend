class Api::V1::ToppingsController < Api::V1::BaseController
  before_action :set_topping, only: [ :show, :update, :destroy ]

  def index
    authorize Topping
    toppings = Topping.ordered_by_name
    toppings = toppings.by_price_range(params[:min_price], params[:max_price]) if params[:min_price] && params[:max_price]

    result = paginate_collection(toppings)

    render json: ToppingSerializer.new(result[:data], {
      meta: result[:meta]
    }).serializable_hash
  end

  def show
    authorize @topping
    render json: ToppingSerializer.new(@topping, {
      include: [ :pizzas ]
    }).serializable_hash
  end

  def create
    authorize Topping
    topping = Topping.new(topping_params)

    if topping.save
      render json: ToppingSerializer.new(topping).serializable_hash, status: :created
    else
      render json: {
        error: "Validation failed",
        details: topping.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    authorize @topping
    if @topping.update(topping_params)
      render json: ToppingSerializer.new(@topping).serializable_hash
    else
      render json: {
        error: "Validation failed",
        details: @topping.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @topping
    if @topping.pizzas.any?
      render json: {
        error: "Cannot delete topping",
        message: "Topping is used by one or more pizzas"
      }, status: :unprocessable_entity
    else
      @topping.destroy
      head :no_content
    end
  end

  private

  def set_topping
    @topping = Topping.find(params[:id])
  end

  def topping_params
    params.require(:topping).permit(:name, :price)
  end
end
