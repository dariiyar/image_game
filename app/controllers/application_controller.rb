class ApplicationController < ActionController::Base
  rescue_from StandardError, with: ->(e) { render_error(e) }

  private

  def render_error(e)
    render json: { errors: e.to_s }, status: 500
  end
end
