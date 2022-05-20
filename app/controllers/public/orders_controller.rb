class Public::OrdersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
    
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
    @cart_items = current_customer.cart_items
    
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    
    @order = Order.new(order_params)
    
    if params[:order][:my_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    
    elsif params[:order][:my_address] == "2"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name
    
    elsif params[:order][:my_address] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @ship = "1"

    
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    
    
    if @order.save
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price * cart_item.amount
      @order_detail.save
      end
    # 最後にカートを全て削除する
    @cart_items.destroy_all
    
     redirect_to thanx_orders_path
    end
  end

  def thanx
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :shipping_cost)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end