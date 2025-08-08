class Api::V1::BaseController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def record_not_found(exception)
    render json: {
      error: "Record not found",
      message: exception.message
    }, status: :not_found
  end

  def record_invalid(exception)
    render json: {
      error: "Validation failed",
      message: exception.message,
      details: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def parameter_missing(exception)
    render json: {
      error: "Parameter missing",
      message: exception.message
    }, status: :bad_request
  end

  def user_not_authorized
    render json: {
      error: "Access denied",
      message: "You are not authorized to perform this action"
    }, status: :forbidden
  end

  def paginate_collection(collection, per_page: 25)
    page = params[:page]&.to_i || 1
    per_page = [ params[:per_page]&.to_i || per_page, 100 ].min

    {
      data: collection.limit(per_page).offset((page - 1) * per_page),
      meta: {
        current_page: page,
        per_page: per_page,
        total_count: collection.count,
        total_pages: (collection.count.to_f / per_page).ceil
      }
    }
  end
end
