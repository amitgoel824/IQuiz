class User < ActiveRecord::Base
	has_many :scores
	attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         def admin?
         	admin
         end
end
