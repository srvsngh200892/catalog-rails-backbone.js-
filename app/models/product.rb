# == Schema Information
#
# Table name: products
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  description            :text
#  price                  :float
#  created_at             :datetime
#  updated_at             :datetime

class Product < ActiveRecord::Base
  validates :name, :description, :price, presence: true
end
