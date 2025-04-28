# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :admin
  belongs_to :province
  
  # Corrected association - remove any extra parentheses or options if present
  has_many :order_items, dependent: :destroy

  STATUSES = %w[
    order_created
    preparing
    shipped
    on_way
    delivered
    cancelled
  ].freeze
  validates :status, inclusion: { in: STATUSES }



  


  validates :address, :payment_method, presence: true
  validates :subtotal, :tax, :total, numericality: { greater_than_or_equal_to: 0 }



 
end