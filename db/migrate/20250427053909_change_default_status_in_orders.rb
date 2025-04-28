class ChangeDefaultStatusInOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_default :orders, :status, from: nil, to: "order_created"
  end
end
