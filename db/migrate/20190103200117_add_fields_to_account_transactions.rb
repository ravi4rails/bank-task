class AddFieldsToAccountTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :account_transactions, :before_transaction_amount, :integer
    add_column :account_transactions, :after_transaction_amount, :integer
  end
end
