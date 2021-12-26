# frozen_string_literal: true

require 'test_helper'

class BottlesControllerTest < ActionDispatch::IntegrationTest
  let(:wine_cellar__d) { FactoryBot.create(:wine_cellar__d) }

  describe '#create' do
    it 'creates a bottle if all params are ok' do
      post__c '/bottles', params: { name: 'wine', wine_cellar_id: wine_cellar__d.id }
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
      post__c '/bottles', params: { name: '', wine_cellar_id: wine_cellar__d.id }
      assert_response :bad_request
      assert_nil Bottle.last
    end
  end

  describe '#update' do
    let(:bottle) { FactoryBot.create(:bottle, id: 12, name: 'original name', wine_cellar: wine_cellar__d) }
    let(:other_cellar) { FactoryBot.create(:wine_cellar) }

    it 'updates a bottle if all params are ok' do
      bottle
      patch__c '/bottles/12', params: { name: 'new name', wine_cellar_id: wine_cellar__d.id }
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
      assert_equal wine_cellar__d, bottle.wine_cellar
    end

    it 'returns a 400 if missing params' do
      bottle
      patch__c '/bottles/12', params: { name: '' }
      assert_response :bad_request
      bottle.reload
      assert_equal 'original name', bottle.name
    end
  end

  describe '#index' do
    it 'returns a 200 if there is some' do
      FactoryBot.create(:bottle, name: 'my first bottle', wine_cellar: wine_cellar__d)
      3.times { FactoryBot.create(:bottle, wine_cellar: wine_cellar__d) }
      FactoryBot.create(:bottle)
      get__c '/bottles'
      assert_response :success
      assert_equal 4, response_body.size
      assert_equal 'my first bottle', response_body.first['name']
    end

    it 'returns an empty array if no result' do
      get__c '/bottles'
      assert_response :success
      assert_equal 0, response_body.size
    end
  end
end
