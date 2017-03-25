module Api
  module V1
    class ProductsSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :description,
                 :price,
                 :created_at,
                 :updated_at
    end
  end
end
