class RemoveGoogleIdFromAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_index :accounts, name: :index_accounts_on_google_id
    remove_column :accounts, :google_id
  end
end
