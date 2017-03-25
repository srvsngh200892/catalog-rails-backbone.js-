require 'spec_helper'

describe MainController, type: :controller do
  before(:all) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end

  describe "#index", focus: true do
    it 'should hit index and return success' do
      expect(response.status).to eq(200)
    end
  end
end
