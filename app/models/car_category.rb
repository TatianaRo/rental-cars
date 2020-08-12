class CarCategory < ApplicationRecord
    validates :name, :daily_rate, :car_insurance,
              :third_party_insurance, presence: true #{message: 'não pode ficar em branco'} o i18n já traduz a mensagem 
    validates :name, uniqueness: true
end
