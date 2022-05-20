class Order < ApplicationRecord
  belongs_to :customer
	has_many :order_details, dependent: :destroy

	validates :customer_id, presence: true
	validates:address, presence: true
	validates:name, presence: true
	validates:shipping_cost,presence: true
	validates:total_payment, presence: true
	validates:payment_method,presence: true
			  		
			  		
  def sum_of_price
    item.add_tax_price * amount
  end  
	

enum payment_method: { credit_card: 0, transfer: 1 }
enum status: {"入金待ち": 0,"入金確認": 1,"製作中": 2,"発送準備中": 3, "発送済み": 4}
end
