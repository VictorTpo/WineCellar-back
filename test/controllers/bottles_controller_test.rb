# frozen_string_literal: true

require 'test_helper'

class BottlesControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    it 'creates a bottle and returns an id' do
      post '/bottles', params: { name: 'wine' }
      assert_response :success
      bottle = Bottle.last
      assert bottle
      assert_equal 'wine', bottle.name
    end

    it 'returns a 500 if no name' do
      post '/bottles', params: { name: '' }
      assert_response :bad_request
      assert_nil Bottle.last
    end
  end
end
