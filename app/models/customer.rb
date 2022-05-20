class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :cart_items, dependent: :destroy       
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  
  def full_name
    self.last_name + " " + self.first_name
  end
  
  def kana_full_name
    kana_last_name + " " + kana_first_name
  end
         
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :kana_last_name, presence: true
  validates :kana_first_name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, uniqueness: true
end
