class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  enum status: {
    active: 0,
    inactive: 1 
  }

  def admin?
    roles.exists?(role_name: 'Admin')  
  end

end
