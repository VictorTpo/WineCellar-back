# frozen_string_literal: true

require 'test_helper'

class BottlesControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    let(:wine_cellar) { FactoryBot.create(:wine_cellar, account: default_account) }

    it 'creates a bottle if all params are ok' do
      post__c '/bottles', params: { name: 'wine', wine_cellar_id: wine_cellar.id }
      assert_response :success
      bottle = Bottle.last
      assert bottle
      assert_equal 'wine', bottle.name
    end

    it 'returns a 400 if you are not owner of wine_cellar' do
      other_wine_cellar = FactoryBot.create(:wine_cellar)
      post__c '/bottles', params: { name: '', wine_cellar_id: other_wine_cellar.id }
      assert_response :bad_request
      assert_nil Bottle.last
    end

    it 'returns a 400 if missing params' do
      post__c '/bottles', params: { name: '', wine_cellar_id: wine_cellar.id }
      assert_response :bad_request
      assert_nil Bottle.last
    end
  end
end
