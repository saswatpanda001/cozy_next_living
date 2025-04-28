# app/models/order_item.rb
class OrderItem < ApplicationRecord
  belongs_to :order       # This creates the association
  belongs_to :product    # Your existing product association
  
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  before_validation :set_price
  
  private
  
  def set_price
    self.price ||= product.price
  end
end