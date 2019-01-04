class Account < ApplicationRecord
  belongs_to :user, optional: true
  has_many :account_transactions, dependent: :destroy
end
