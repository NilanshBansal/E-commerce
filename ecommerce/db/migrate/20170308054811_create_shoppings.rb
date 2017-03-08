class CreateShoppings < ActiveRecord::Migration
  def change
    create_table :shoppings do |t|
      t.integer :userid
      t.integer :productid
      t.date :addtocartdate
      t.date :buydate
      t.integer :qty
      t.string :status

      t.timestamps null: false
    end
  end
end
