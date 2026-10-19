module Rescuable
  extend ActiveSupport::Concern

  ERRORS = {
    ActiveRecord::RecordNotFound => Errors::NotFound,
    # Pundit
    # JWT
    ActionController::ParameterMissing => Errors::BadRequest
  }.freeze

  included do
    rescue_from(*ERRORS.keys) do |exception|
      render_error(ERRORS[exception.class.ancestors.find { |klass| ERRORS.key?(klass) }].new)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      render_error(Errors::Invalid.new(exception.record))
    end

    rescue_from Errors::BaseError do |exception|
      render_error(exception)
    end
  end

  private
    def render_error(error)
      body = { type: error.class.name.demodulize, message: error.message }
      body[:details] = error.details if error.details

      render json: { error: body }, status: error.status
    end
end
