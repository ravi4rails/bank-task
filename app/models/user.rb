class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin manager customer].freeze       

  has_many :accounts

  ROLES.each do |role|
    define_method "#{role}?" do 
      self.role == "#{role}"
    end
  end

end
