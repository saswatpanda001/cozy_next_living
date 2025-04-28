class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :admin, null: false, foreign_key: true
      t.string :status
      t.decimal :subtotal
      t.decimal :tax
      t.decimal :total
      t.string :address
      t.string :payment_method
      t.bigint :province_id

      t.timestamps
    end
  end
end
