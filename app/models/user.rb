class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #Retirar registerable faz com que a aplicação não tenha cadastro

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


end
