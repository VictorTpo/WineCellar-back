# frozen_string_literal: true

require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    it 'returns 200 and creates an account if everything is ok' do
      account_params = { email: 'new@mail.com', first_name: 'Bruce', last_name: 'Wayne', password: 'pwd' }
      post '/accounts', params: account_params.to_json, headers: { 'Content-Type' => 'application/json' }
      assert_response :success
      account = Account.find_by(email: 'new@mail.com')
      assert account
    end

    it 'returns a 400 if missing some params' do
      account_params = { email: 'new@mail.com', first_name: 'Bruce', last_name: 'Wayne', password: '' }
      post '/accounts', params: account_params.to_json, headers: { 'Content-Type' => 'application/json' }

      assert_response :bad_request
      assert_nil Account.find_by(email: 'new@mail.com')
    end
  end
end
