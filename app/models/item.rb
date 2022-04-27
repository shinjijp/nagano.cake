class Item < ApplicationRecord
  belongs_to :genre
  
  has_one_attached :image
  
  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :genre_id, presence: true
  
  def  add_tax_price
   (self.price * 1.10).round
  end
  
end
