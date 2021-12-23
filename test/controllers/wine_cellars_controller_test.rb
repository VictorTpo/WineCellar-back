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
    end
    focus
    it 'returns a 400 if missing params' do
      post '/wine_cellars', params: { name: 'my first cellar' }
      assert_response :bad_request
      assert_empty WineCellar.all
    end
  end
end
