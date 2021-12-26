# frozen_string_literal: true

class CreateAccount < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :google_id
      t.timestamps
    end

    add_index :accounts, :email, unique: true
    add_index :accounts, :google_id, unique: true
  end
end
