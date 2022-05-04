class Admin::HomesController < ApplicationController
  def top
    @params = params[:id]
    @order = Order.where(customer_id: @params)
    @orders = Order.page(params[:id])
  end
end
