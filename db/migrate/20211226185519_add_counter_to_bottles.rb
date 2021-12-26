class AddCounterToBottles < ActiveRecord::Migration[7.0]
  def change
    add_column :bottles, :counter, :integer, null: false, default: 1
  end
end
