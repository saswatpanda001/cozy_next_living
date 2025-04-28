class CartsController < ApplicationController
    before_action :initialize_cart

    def add_item
        product_id = params[:product_id].to_i
        quantity = params[:quantity].to_i
    
        @cart.add_item(product_id, quantity)
        save_cart
        redirect_to cart_path, notice: "Item added to cart."
      end

  
    def show
      
        @cart_items = load_cart_items
      
    end
  
    def update_quantity
      @cart.update_quantity(params[:product_id].to_i, params[:quantity].to_i)
      save_cart
      redirect_to cart_path
    end
  
    def remove_item
      @cart.remove_item(params[:product_id].to_i)
      save_cart
      redirect_to cart_path
    end
  
    private
  
    def initialize_cart
      session[:cart] ||= []
      @cart = Cart.new(session[:cart])
    end
  
    def save_cart
    
      session[:cart] = @cart.items
    end
  
    def load_cart_items
      products = Product.where(id: @cart.items.map { |i| i['product_id'] }).index_by(&:id)
      
      @province = current_admin&.province
      @subtotal = @cart.items.sum { |item| product = products[item['product_id'].to_i]; product ? product.price * item['quantity'] : 0 }
    
      @cart.items.map do |item|
        product = products[item['product_id'].to_i]
        next unless product
    
        { product: product, quantity: item['quantity'] }
      end.compact
    end
    
  end
  