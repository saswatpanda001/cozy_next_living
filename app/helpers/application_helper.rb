module ApplicationHelper
end

def cart_items_count
    session[:cart]&.sum { |item| item['quantity'] } || 0
  end
  