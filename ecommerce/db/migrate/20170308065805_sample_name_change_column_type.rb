class SampleNameChangeColumnType < ActiveRecord::Migration
  def self.up
  	change_column(:shoppings,:addtocartdate,:datetime)
  end

  def self.down
  	change_column(:shoppings,:addtocartdate,:date)
  end
end
