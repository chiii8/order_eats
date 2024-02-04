class CreateItemCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :item_categories do |t|
      t.string :name, null: false
      t.integer :store_id, null: false
      t.timestamps
    end
  end
end
