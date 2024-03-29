class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, null: false, default: true
      t.references :store, foreign_key: true
      t.timestamps
      t.integer :item_category_id
    end
  end
end
