# frozen_string_literal: true

class CreateBottle < ActiveRecord::Migration[7.0]
  def change
    create_table :bottles do |t|
      t.string :name, null: false, index: true
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
