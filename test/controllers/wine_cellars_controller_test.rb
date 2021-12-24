# frozen_string_literal: true

require 'test_helper'

class WineCellarsControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    it 'returns a 200 with correct params' do
      account = FactoryBot.create(:account, id: 12)
      post '/wine_cellars', params: { name: 'my first cellar', account_id: 12 }
      assert_response :success
      wine_cellar = WineCellar.find_by(name: 'my first cellar')
      assert wine_cellar
      assert_equal account, wine_cellar.account
      assert_equal 'my first cellar', response_body['name']
    end

    it 'returns a 400 if missing params' do
      post '/wine_cellars', params: { name: 'my first cellar' }
      assert_response :bad_request
      assert_empty WineCellar.all
    end
  end

  describe '#show' do
    it 'returns a 200 if it exists' do
      FactoryBot.create(:wine_cellar, id: 12, name: 'my cellar')
      get '/wine_cellars/12'
      assert_response :success
      assert_equal 'my cellar', response_body['name']
    end

    it 'returns a 404 if it does not exist' do
      get '/wine_cellars/12'
      assert_response :not_found
    end
  end
end
