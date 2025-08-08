class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    token = request.headers["Authorization"]&.split(" ")&.last
    return unless token

    begin
      decoded_token = JwtService.decode(token)
      @current_user = User.find(decoded_token[:user_id])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      @current_user = nil
    end
  end

  def current_user
    @current_user
  end

  def authenticate_user!
    unless current_user
      render json: { error: "Authentication required" }, status: :unauthorized
    end
  end
end
