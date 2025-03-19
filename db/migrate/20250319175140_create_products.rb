class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :inventory_count
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
