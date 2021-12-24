# frozen_string_literal: true

require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    it 'returns a 200 if account already exists' do
      FactoryBot.create(:account, email: 'existing@mail.com', id: 12)
      post '/accounts', params: { email: 'existing@mail.com' }
      assert_response :success
      assert_equal 12, response_body['id']
    end

    it 'returns 200 and creates an account if everything is ok' do
      account_params = { email: 'new@mail.com', first_name: 'Bruce', last_name: 'Wayne' }
      post '/accounts', params: account_params
      assert_response :success
      account = Account.find_by(email: 'new@mail.com')
      assert account
      assert_equal account.id, response_body['id']
    end

    it 'returns a 400 if missing some params' do
      post '/accounts', params: { email: 'new@mail.com' }
      assert_response :bad_request
      assert_nil Account.find_by(email: 'new@mail.com')
    end
  end
end
