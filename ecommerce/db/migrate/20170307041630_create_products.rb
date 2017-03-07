class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.string :color
      t.string :category
      t.integer :sellerid
      t.string :description

      t.timestamps null: false
    end
  end
end
