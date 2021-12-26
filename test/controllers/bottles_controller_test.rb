# frozen_string_literal: true

require 'test_helper'

class BottlesControllerTest < ActionDispatch::IntegrationTest
  let(:wine_cellar) { FactoryBot.create(:wine_cellar, account: default_account) }

  describe '#create' do
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

  describe '#update' do
    let(:bottle) { FactoryBot.create(:bottle, id: 12, name: 'original name', wine_cellar: wine_cellar) }
    let(:other_cellar) { FactoryBot.create(:wine_cellar) }

    it 'updates a bottle if all params are ok' do
      bottle
      patch__c '/bottles/12', params: { name: 'new name', wine_cellar_id: wine_cellar.id }
      assert_response :success
      bottle.reload
      assert_equal 'new name', bottle.name
    end

    it 'returns a 400 if you are not owner of wine_cellar' do
      bottle = FactoryBot.create(:bottle, id: 12, name: 'original name', wine_cellar: other_cellar)
      patch__c '/bottles/12', params: { name: '' }
      assert_response :bad_request
      bottle.reload
      assert_equal 'original name', bottle.name
    end

    it 'returns 400 if you put it in another cellar' do
      bottle
      patch__c '/bottles/12', params: { name: 'new name', wine_cellar_id: other_cellar.id }
      assert_response :bad_request
      bottle.reload
      assert_equal wine_cellar, bottle.wine_cellar
    end

    it 'returns a 400 if missing params' do
      patch__c '/bottles/12', params: { name: '' }
      assert_response :bad_request
      bottle.reload
      assert_equal 'original name', bottle.name
    end
  end
end
