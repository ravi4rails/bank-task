class AccountsController < ApplicationController

  before_action :set_account, only: [
    :show, 
    :edit, 
    :update, 
    :destroy, 
    :deposite_money, 
    :withdrawal_money, 
    :balance_enquiry, 
    :update_deposite_amount, 
    :update_withdrawal_amount
  ]

  before_action :authenticate_user!
  
  def index
    if current_user.customer?
      @accounts = current_user.accounts
    else
      @accounts = Account.all
    end
  end
 
  def new 
    @account = Account.new   
  end

  def show
    @transactions = @account.account_transactions
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to @account, flash: { success: "Account has been created successfully" }
    else
      render :new
    end
  end
  
  def update
    if @account.update(account_params)
      redirect_to @account, flash: { success: "Account has been updated successfully" }
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path, flash: { success: "Account has been deleted successfully" }
  end

  def deposite_money
  end

  def withdrawal_money
  end

  def balance_enquiry
    @account.account_transactions.create(transaction_type: 'Enquiry', before_transaction_amount: @account.balance, after_transaction_amount: @account.balance)

    # Email notification for user(account holder) for balance enquiry transaction
    CustomerNotificationMailer.balance_enquiry_notification(current_user, @account).deliver_now
  end

  def update_deposite_amount
    @current_balance = @account.balance
    @amount = params[:deposite][:amount].to_i
    @account.update(balance: @current_balance + @amount)
    
    @account.account_transactions.create(transaction_type: 'Deposite', before_transaction_amount: @current_balance, after_transaction_amount: @account.balance)
    
    # Email notification for user(account holder) for deposite transaction
    CustomerNotificationMailer.deposite_notification(current_user, @account, @amount, @current_balance).deliver_now
    redirect_to deposite_money_account_path(@account), flash: { success: "Amount has been deposited successfully" }  
  end

  def update_withdrawal_amount
    @current_balance = @account.balance
    if params[:withdrawal][:amount].to_i <= @current_balance
      @amount = params[:withdrawal][:amount].to_i
      @account.update(balance: @current_balance - @amount)
      
      @account.account_transactions.create(transaction_type: 'Withdrawal', before_transaction_amount: @current_balance, after_transaction_amount: @account.balance)
      
      # Email notification for user(account holder) for withdrawal transaction
      CustomerNotificationMailer.withdrawal_notification(current_user, @account, @amount, @current_balance).deliver_now
      redirect_to withdrawal_money_account_path(@account), flash: { success: "Amount has been withdrawal successfully" }
    else
      redirect_to withdrawal_money_account_path(@account), flash: { error: "You don't have enough amount into your account" }
    end
  end

  private

    def account_params
      params.require(:account).permit!
    end

    def set_account
      @account = Account.find(params[:id])
    end


end