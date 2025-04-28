class FixOrderRelationships < ActiveRecord::Migration[6.1]
  def change
    # Remove the incorrect foreign key from orders to order_items
    remove_reference :orders, :order_item, foreign_key: { to_table: :order_items }

    # Add proper reference from order_items to orders if it doesn't exist
    unless foreign_key_exists?(:order_items, :orders)
      add_foreign_key :order_items, :orders
    end

    # Make order_id non-nullable in order_items if it isn't already
    change_column_null :order_items, :order_id, false
  end
end