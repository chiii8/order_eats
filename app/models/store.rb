class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image
   
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/logo.PNG')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favorited_by?(current_customer)
    favorites.exists?(customer_id: current_customer.id)
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "id", "introduction", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "telephone_number", "updated_at"]
  end
  
  with_options presence: true do
    validates :name
    validates :address
    validates :telephone_number
  end
end
