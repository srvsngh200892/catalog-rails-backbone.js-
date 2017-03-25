require 'spec_helper'

describe Api::V1::ProductsController, type: :controller do

  before(:all) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
    @product = Product.find_by(name: 'product1') || FactoryGirl.create(:product)
  end

  describe "#index", focus: true do
    it 'should hit index and return success' do
        request_json={
        :format => :json
      }
        get :index, request_json
        expect(response.status).to eq(200)
        hash_body = JSON.parse(response.body)
        expect(hash_body[0]['name']).to eq('product1')
        expect(hash_body.length).to eq(1)
    end
  end


  describe "#create", focus: true do
      it 'should hit create and return success' do
        request_json={
        :name=>'product10',
        :description  =>"its a very good product",
        :price => 200,
        :format => :json
      }
        get :create, request_json
        expect(response.status).to eq(201)
        hash_body = JSON.parse(response.body)
        expect(hash_body['name']).to eq('product10')
        expect(hash_body['price']).to eq(200.0)
        expect(hash_body['description']).to eq('its a very good product')
    end

    it 'should hit create and return bad request as we are not passing name parameter' do
        request_json={
        :description  =>"its a very good product",
        :price => 200,
        :format => :json
      }
        get :create, request_json
        expect(response.status).to eq(400)
    end

     it 'should hit create and return bad request as we are not passing description parameter' do
        request_json={
        :name=>'product10',
        :price => 200,
        :format => :json
      }
        get :create, request_json
        expect(response.status).to eq(400)
    end

    it 'should hit create and return bad request as we are not passing price parameter' do
        request_json={
        :name=>'product10',
        :description  =>"its a very good product",
        :format => :json
      }
        get :create, request_json
        expect(response.status).to eq(400)
    end

    it 'should hit create and return bad request as we are not passing any parameter' do
        request_json={
        :format => :json
      }
        get :create, request_json
        expect(response.status).to eq(400)
    end
  end

  describe "#show", focus: true do
    it 'should hit show and return success' do
      get :show, id: @product.id
      expect(response.status).to eq(200)
      hash_body = JSON.parse(response.body)
      expect(hash_body['name']).to eq('product1')
    end

    it 'should hit show and return 403 for record not found' do
      get :show, id: 100
      expect(response.status).to eq(403)
    end
  end

  describe "#update", focus: true do
    it 'should hit update and return success' do
        request_json={
        id: @product.id,
        :description  =>"its a very best product",
        :price => 201,
        :format => :json
        }
        put :update, request_json
        expect(response.status).to eq(200)
        hash_body = JSON.parse(response.body)
        expect(hash_body['price']).to eq(201.0)
        expect(hash_body['description']).to eq('its a very best product')
    end

    it 'should hit update and return 403 for record not found' do
      put :update, id: 100
      expect(response.status).to eq(403)
    end

    it 'should hit update and return return unproccessed entity as description is blank' do
        request_json={
        id: @product.id,
        :description  =>"",
        :price => 201,
        :format => :json
        }
        put :update, request_json
        expect(response.status).to eq(422)
    end
  end

  describe "#destroy", focus: true do
    it 'should hit destroy and return success' do
      delete :destroy, id: @product.id
      expect(response.status).to eq(200)
    end

    it 'should hit destroy and return 403 for record not found' do
      delete :destroy, id: 100
      expect(response.status).to eq(403)
    end
  end
end
