class AccountTransactionsController < ApplicationController

  def index
    @account_transactions = AccountTransaction.all
    respond_to do |format|
      format.html
      format.xls 
      format.csv { send_data @account_transactions.to_csv }
    end
  end

end 
