class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :profile_image
  
  enum gender: { male: 0, female: 1, no_answer: 2 }
  
  def active_for_authentication?
    super && (is_active == true ) # 有効でないとログインできない
  end
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/logo.PNG')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def full_name
    last_name + first_name
  end
  
  def full_name_kana
    last_name_kana + first_name_kana
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@email.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "ゲスト"
      customer.first_name = "太郎"
      customer.last_name_kana = "ゲスト"
      customer.first_name_kana = "タロウ"
      customer.telephone_number = "00000000000"
      customer.gender = "no_answer"
      customer.is_active = true
    end
  end
  
  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
    validates :gender
  end
end