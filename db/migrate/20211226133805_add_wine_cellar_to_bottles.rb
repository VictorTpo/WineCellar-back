class AddWineCellarToBottles < ActiveRecord::Migration[7.0]
  def change
    add_reference :bottles, :wine_cellar, null: false, foreign_key: true
  end
end
