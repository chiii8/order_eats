class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :reviews, dependent: :destroy
  
  enum payment_method: { credit_card: 0, cash: 1}
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/logo.PNG')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def subtotal
    payment_amount - fee
  end
end