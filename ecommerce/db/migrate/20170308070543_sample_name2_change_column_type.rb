class SampleName2ChangeColumnType < ActiveRecord::Migration
   def self.up
  	change_column(:shoppings,:buydate,:datetime)
  end

  def self.down
  	change_column(:shoppings,:buydate,:date)
  end
end
