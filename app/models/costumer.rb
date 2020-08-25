class Costumer < ApplicationRecord

    validates :name, :document, :email, presence: true 
    validates :document, uniqueness: true
    validates :document, length: { is: 11}
    validate :validates_cpf

    def validates_cpf
      if !document.blank? and !CPF.valid?(document)
       errors.add(:document, "inválido") 
      end
    end

    def information
      "#{name} - #{document}"
    end
end
