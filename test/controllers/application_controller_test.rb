# frozen_string_literal: true

require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  it 'authenticates when JWT is correct' do
    FactoryBot.create(:account, id: 12)
    get '/wine_cellars', headers: headers
    assert_response :success
  end

  it 'fails if the request is not authenticated' do
    get '/wine_cellars', headers: headers('Bearer wr0ngT0k3n')
    assert_response :unauthorized
  end

  private

  def build_jwt_token
    payload = { account_id: 12 }
    JWT.encode(
      payload,
      Figaro.env.jwt_secret,
      ApplicationController::JWT_ALGORITHM
    )
  end

  def headers(token = build_jwt_token)
    {
      'Authorization' => "Bearer #{token}",
      'Content-Type' => 'application/json',
    }
  end
end
