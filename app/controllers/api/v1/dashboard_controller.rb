class Api::V1::DashboardController < Api::V1::BaseController
  def index
    # Only authenticated users can access dashboard
    authorize :dashboard, :index?

    dashboard_data = {
      statistics: {
        total_toppings: Topping.count,
        total_pizzas: Pizza.count,
        total_users: User.count
      }
    }

    render json: {
      dashboard: dashboard_data
    }
  end
end
