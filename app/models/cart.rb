class Cart
    attr_reader :items
  
    def initialize(items = [])
      @items = items
    end
  
    def add_item(product_id, quantity = 1)
      existing_item = items.find { |item| item['product_id'] == product_id }
      if existing_item
        existing_item['quantity'] += quantity.to_i
      else
        items << { 'product_id' => product_id, 'quantity' => quantity.to_i }
      end
    end
  
    def remove_item(product_id)
      items.reject! { |item| item['product_id'] == product_id }
    end
  
    def update_quantity(product_id, new_quantity)
      item = items.find { |i| i['product_id'] == product_id }
      item['quantity'] = new_quantity.to_i if item && new_quantity.to_i > 0
    end
  
    def total_items
      items.sum { |item| item['quantity'] }
    end
  
    def empty?
      items.empty?
    end


  end
  