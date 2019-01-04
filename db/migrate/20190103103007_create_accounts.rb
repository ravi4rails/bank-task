class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :bank_name
      t.string :account_number
      t.integer :balance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
