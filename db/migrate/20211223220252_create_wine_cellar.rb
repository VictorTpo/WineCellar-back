# frozen_string_literal: true

class CreateWineCellar < ActiveRecord::Migration[7.0]
  def change
    create_table :wine_cellars do |t|
      t.string :name, null: false, index: true
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
