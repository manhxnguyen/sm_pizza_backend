class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [ :login ]

  def login
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = generate_jwt_token(user)
      render json: {
        message: "Login successful",
        user: user_response(user),
        token: token
      }
    else
      render json: {
        error: "Invalid credentials"
      }, status: :unauthorized
    end
  end

  def profile
    render json: {
      user: user_response(current_user)
    }
  end

  def logout
    # Since we're using stateless JWT tokens, logout is handled client-side
    # by simply removing the token from storage
    render json: {
      message: "Logged out successfully"
    }
  end

  private

  def generate_jwt_token(user)
    JWT.encode(
      {
        user_id: user.id,
        exp: 24.hours.from_now.to_i
      },
      Rails.application.secret_key_base
    )
  end

  def user_response(user)
    {
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      full_name: user.full_name,
      role: user.role,
      permissions: {
        can_manage_toppings: user.can_manage_toppings?,
        can_manage_pizzas: user.can_manage_pizzas?,
        can_manage_users: user.can_manage_users?
      }
    }
  end
end
