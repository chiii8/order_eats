class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :quantity, null: false
      t.string :number, null: false
      t.integer :payment_amount, null: false
      t.boolean :making_status, null: false, default: 0
      t.timestamps
    end
  end
end

