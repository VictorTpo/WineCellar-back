# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    let(:account) { FactoryBot.create(:account, email: 'bruce@wayne.com', password: 'b@tm@n') }

    it 'returns 200 and token if email<>pwd' do
      account
      params = { email: 'bruce@wayne.com', password: 'b@tm@n' }
      post '/sessions', params: params.to_json, headers: { 'Content-Type' => 'application/json' }
      assert_response :success
      assert response_body['jwt_token']
    end

    it 'returns 400 and no token if email</>pwd' do
      account
      params = { email: 'bruce@wayne.com', password: 'sup3rm@n' }
      post '/accounts', params: params.to_json, headers: { 'Content-Type' => 'application/json' }

      assert_response :bad_request
      assert_nil response_body['token']
    end
  end
end
