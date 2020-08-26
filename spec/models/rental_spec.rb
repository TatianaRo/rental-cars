require 'rails_helper'

RSpec.describe Rental, type: :model do
    context 'token' do
        it 'generate on create' do
            costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
            car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                               third_party_insurance: 10.5)
            user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')                                   
            rental = Rental.new(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                car_category: car_category, user: user)
            rental.save
            
            expect(rental.token).to be_present
            expect(rental.token.size).to eq(6)
            expect(rental.token).to match(/^[A-Z0-9]+$/)
        end 
        
        xit 'must be unique' do
        end    
    end    
end
