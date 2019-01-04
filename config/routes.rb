Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  devise_for :users, controllers: {
    sessions:       'users/sessions',
    registrations:  'users/registrations'
  }
  root 'home#index'

  resources :accounts do 
    member do 
      get   :deposite_money
      get   :withdrawal_money
      get   :balance_enquiry
      patch :update_deposite_amount
      patch :update_withdrawal_amount
    end
  end
  resources :account_transactions, only: :index

  resources :users, only: [:index, :show, :destroy]

end
