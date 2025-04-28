# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = current_admin.orders.order(created_at: :desc)
  end

  def show
    @order = current_admin.orders.find(params[:id])
  end
end