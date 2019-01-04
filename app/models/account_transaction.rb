class AccountTransaction < ApplicationRecord

  require 'csv'

  belongs_to :account, optional: true

  scope :deposite_transactions, -> { where(transaction_type: 'Deposite') }
  scope :withdrawal_transactions, -> { where(transaction_type: 'Withdrawal') }
  scope :enquiry_transactions, -> { where(transaction_type: 'Enquiry') }

  def self.to_csv(options = {})
    desired_columns = ["id", "transaction_type", "before_transaction_amount", "after_transaction_amount", "created_at"]
    desired_columns << "account_number"
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |account_transaction|
        row = account_transaction.attributes.values_at(*desired_columns)
        row << Account.find(account_transaction.account.id).account_number.to_s
        csv << row
      end
    end
  end

end
