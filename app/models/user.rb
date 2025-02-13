class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :products
  has_one :cart

  enum status: {
    active: 0,
    inactive: 1 
  }

  def admin?
    roles.exists?(role_name: 'Admin')  
  end

  def owner?
    roles.exists?(role_name: 'Owner')
  end

end
