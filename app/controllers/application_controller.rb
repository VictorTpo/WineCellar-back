# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def render_errors(object)
    render json: { messages: object.errors }, status: 400
  end
end
