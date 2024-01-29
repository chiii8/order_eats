class StoreCategory < ApplicationRecord
  has_many :stores, dependent: :destroy
  
  validates :name, presence: true
end
