class AddPasswordToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :password_digest, :string, null: false
  end
end
