# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate

  JWT_ALGORITHM = 'HS256'

  def authenticate
    authenticate_or_request_with_http_token do |jwt, _options|
      decoded_payload = JWT.decode(jwt, Figaro.env.jwt_secret, algorithm: JWT_ALGORITHM)
      content_payload = decoded_payload.first
      set_current_account(content_payload['account_id'])
    end
  rescue JWT::ExpiredSignature, JWT::ImmatureSignature, JWT::VerificationError, JWT::DecodeError
    head :unauthorized
  end

  def render_errors(object)
    render json: { messages: object.errors }, status: 400
  end

  def current_account
    @_current_account
  end

  private

  def set_current_account(account_id)
    @_current_account = Account.find(account_id)
  end
end
