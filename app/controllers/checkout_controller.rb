class CheckoutController < ApplicationController
  before_action :load_cart
  before_action :set_order, only: [:new, :create]
  before_action :set_taxes_and_subtotal, only: [:new, :create]

  def new
    if current_admin&.province.nil?
      redirect_to edit_admin_path(current_admin), alert: "Please set your province before checkout"
      return
    end
  end

  def create
    @order.assign_attributes(order_params)
    @order.status = :order_created
    @order.province_id = current_admin.province_id

    # Use the freshly calculated values
    @order.subtotal = @subtotal  
    @order.gst_amount = @taxes[:gst]
    @order.pst_amount = @taxes[:pst]
    @order.hst_amount = @taxes[:hst]
    @order.tax = @taxes[:gst]+ @taxes[:pst]+@taxes[:hst]
    @order.total = @subtotal + @taxes[:gst]+ @taxes[:pst]+@taxes[:hst]

     # Print values for debugging
  Rails.logger.debug "Subtotal: #{@order.subtotal}"
  Rails.logger.debug "GST Amount: #{@order.gst_amount}"
  Rails.logger.debug "PST Amount: #{@order.pst_amount}"
  Rails.logger.debug "HST Amount: #{@order.hst_amount}"
  Rails.logger.debug "Total Tax: #{@order.tax}"
  Rails.logger.debug "Total: #{@order.total}"

  

    # Build order items from cart
    @cart.items.each do |item|
      product = Product.find(item['product_id'])
      @order.order_items.build(
        product: product,
        quantity: item['quantity'],
        price: product.price
      )
    end

    if @order.save
      session[:cart] = nil
      redirect_to orders_path, notice: 'Order placed successfully!'
    else
      set_taxes_and_subtotal # recalculate taxes and subtotal again if errors happen
      render :new
    end
  end

  private

  def set_order
    if current_admin
      @order = current_admin.orders.new(province_id: current_admin.province_id)
    else
      redirect_to login_path, alert: "Please log in to proceed to checkout"
    end
  end

  def load_cart
    @cart = Cart.new(session[:cart] || [])
    redirect_to cart_path, alert: 'Your cart is empty' if @cart.empty?
  end

  def set_taxes_and_subtotal
    if current_admin&.province
      @province = current_admin.province
      @subtotal = calculate_subtotal(@cart)
      @taxes = calculate_taxes(@subtotal, @province)
    end
  end

  def order_params
    params.require(:order).permit(:address, :payment_method)
  end

  def calculate_subtotal(cart)
    cart.items.sum do |item|
      product = Product.find(item['product_id'])
      product.price * item['quantity']
    end
  end

  def calculate_taxes(subtotal, province)
    {
      gst: subtotal * (province.gst.to_f / 100),
      pst: subtotal * (province.pst.to_f / 100),
      hst: subtotal * (province.hst.to_f / 100),
      total: subtotal * ((province.gst.to_f + province.pst.to_f + province.hst.to_f) / 100)
    }
  end
end
