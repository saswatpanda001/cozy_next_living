class AddOrderItemToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :order_item, null: false, foreign_key: true
  end
end
