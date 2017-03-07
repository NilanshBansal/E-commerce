class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :userid
      t.string :username
      t.string :password
      t.decimal :balance

      t.timestamps null: false
    end
  end
end
