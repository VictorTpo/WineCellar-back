# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

module ActiveSupport
  class TestCase
    DEFAULT_ACCOUNT_ID = 12

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def response_body
      @_response_body ||= ::JSON.parse(response.body)
    end

    def default_account
      @_default_account ||=
        (Account.find_by(id: DEFAULT_ACCOUNT_ID) || FactoryBot.create(:default_account))
    end

    def headers_for_account
      default_account
      payload = { account_id: default_account.id }
      token = JWT.encode(payload, Figaro.env.jwt_secret!, ApplicationController::JWT_ALGORITHM)
      {
        'Authorization' => "Bearer #{token}",
        'Content-Type' => 'application/json',
      }
    end

    def post__c(url, params: {}, headers: headers_for_account)
      post url, params: params.to_json, headers: headers
    end

    def get__c(url, headers: headers_for_account)
      get url, headers: headers
    end
  end
end
