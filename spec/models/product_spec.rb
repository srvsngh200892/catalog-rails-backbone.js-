require 'spec_helper'

describe Product, type: :model do
  before(:all) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end


  describe 'presence validations' do
    [:name, :description, :price].each do |att|
      it {should validate_presence_of(att)}
    end

    it "should pass validation if name is present" do
      product = FactoryGirl.build(:product, name: "product3", description: "hmmmmm", price: 200)
      product.should be_valid
    end

    it "shouldn't pass validation if is name blank" do
      product = FactoryGirl.build(:product, name: "", description: "hmmmmm", price: 200)
      product.should_not be_valid
    end

    it "should pass validation if price is present" do
      product = FactoryGirl.build(:product, name: "product6", description: "hmmmmm", price: 200)
      product.should be_valid
    end

    it "shouldn't pass validation if is price blank" do
      product = FactoryGirl.build(:product, name: "product7", description: "hmmmmm", price: '')
      product.should_not be_valid
    end

    it "should pass validation if description is present" do
      product = FactoryGirl.build(:product, name: "product5", description: "hmmmmm", price: 200)
      product.should be_valid
    end

    it "shouldn't pass validation if is description blank" do
      product = FactoryGirl.build(:product, name: "product4", description: "", price: 200)
      product.should_not be_valid
    end
  end
end

