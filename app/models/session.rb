# frozen_string_literal: true

class Session
  def initialize(account_id)
    @account_id = account_id
  end

  def generate_jwt_token
    payload = { account_id: @account_id }

    JWT.encode(payload, Figaro.env.jwt_secret, ApplicationController::JWT_ALGORITHM)
  end
end
