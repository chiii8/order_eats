class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.references :customer, null: false, foreign_key: true
      t.references :order_detail, null: false, foreign_key: true
      t.timestamps
    end
  end
end