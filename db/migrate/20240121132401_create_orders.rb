class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :fee, null: false
      t.string :number
      t.integer :payment_method, null: false, default: 0
      t.integer :payment_amount, null: false
      t.timestamps
    end
  end
end
