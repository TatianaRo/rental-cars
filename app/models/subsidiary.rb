require "cpf_cnpj"

class Subsidiary < ApplicationRecord
    validates :name, :cnpj , :address, presence: true
    validates :cnpj, uniqueness: true
    validates :cnpj, length: { is: 14 }
    validate :validate_cnpj

    def validate_cnpj
      unless CNPJ.valid?(cnpj)
        errors.add(:cnpj, "inválido")
      end  
    end  

  
end
