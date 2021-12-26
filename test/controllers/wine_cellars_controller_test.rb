# frozen_string_literal: true

require 'test_helper'

class WineCellarsControllerTest < ActionDispatch::IntegrationTest
  describe '#create' do
    it 'returns a 200 with correct params' do
      post__c '/wine_cellars', params: { name: 'my first cellar' }
      assert_response :success
      wine_cellar = WineCellar.find_by(name: 'my first cellar')
      assert wine_cellar
      assert_equal default_account, wine_cellar.account
      assert_equal 'my first cellar', response_body['name']
    end

    it 'returns a 400 if missing params' do
      post__c '/wine_cellars', params: { name: '' }
      assert_response :bad_request
      assert_empty WineCellar.all
    end
  end

  describe '#update' do
    it 'returns a 200 with correct params' do
      wine_cellar = FactoryBot.create(:wine_cellar, id: 12, name: 'name_1', account: default_account)
      patch__c '/wine_cellars/12', params: { name: 'another name' }
      assert_response :success
      wine_cellar.reload
      assert_equal 'another name', wine_cellar.name
    end

    it 'returns a 400 if missing params' do
      wine_cellar = FactoryBot.create(:wine_cellar, id: 12, name: 'name_1', account: default_account)
      patch__c '/wine_cellars/12', params: { name: '' }
      assert_response :bad_request
      wine_cellar.reload
      assert_equal 'name_1', wine_cellar.name
    end
  end

  describe '#show' do
    it 'returns a 200 if it exists' do
      FactoryBot.create(:wine_cellar, id: 12, name: 'my cellar')
      get__c '/wine_cellars/12'
      assert_response :success
      assert_equal 'my cellar', response_body['name']
    end

    it 'returns a 404 if it does not exist' do
      get__c '/wine_cellars/12'
      assert_response :not_found
    end
  end

  describe '#index' do
    it 'returns a 200 if there is some' do
      FactoryBot.create(:wine_cellar, name: 'a wc name', account: default_account)
      3.times { FactoryBot.create(:wine_cellar, account: default_account) }
      FactoryBot.create(:wine_cellar)
      get__c '/wine_cellars'
      assert_response :success
      assert_equal 4, response_body.size
      assert_equal 'a wc name', response_body.first['name']
    end

    it 'returns an empty array if no result' do
      get__c '/wine_cellars'
      assert_response :success
      assert_equal 0, response_body.size
    end
  end
end
