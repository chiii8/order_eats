class CartItem < ApplicationRecord
    belongs_to :item
    belongs_to :customer
    
    def subtotal
      item.with_tax_price * quantity
    end
    #空でないこと
    validates :quantity, presence: true
end