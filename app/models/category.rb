class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :stores, dependent: :destroy
  
  validates :name, presence: true
end
