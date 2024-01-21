class Favorite < ApplicationRecord
  
  belongs_to :customer
  belongs_to :store
  
  validates :customer_id, uniqueness: {scope: :store_id}
end
