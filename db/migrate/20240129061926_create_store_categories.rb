class CreateStoreCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :store_categories do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
