require 'rails_helper'

RSpec.describe Car, type: :model do
  describe ".description" do 
    it ' should return car model name, color and license plate' do
      car_category = CarCategory.create!(name: 'Top', daily_rate: 100.5, car_insurance: 58.5,
                                         third_party_insurance: 10.5)
      car_model = CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                                   car_category: car_category, fuel_type:'Flex')  
      car = Car.create!(license_plate: 'ABC1234', color: 'Preto', car_model:car_model,
                        mileage: 0)    
      result = car.description()

      expect(result).to eq 'ka - Prata - ABC1234'
    end
  end  
end
