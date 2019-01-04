class CustomerNotificationMailer < ApplicationMailer

  def deposite_notification user, account, amount, current_balance
    @user = user
    @account = account
    @amount = amount
    @previous_amount = current_balance
    mail(to: @user.email, subject: 'Deposite Amount Notification')
  end

  def withdrawal_notification user, account, amount, current_balance
    @user = user
    @account = account
    @amount = amount
    @previous_amount = current_balance
    mail(to: @user.email, subject: 'Withdrawal Amount Notification')
  end

  def balance_enquiry_notification user, account 
    @user = user
    @account = account
    mail(to: @user.email, subject: 'Balance Enquiry Notification')
  end

end
