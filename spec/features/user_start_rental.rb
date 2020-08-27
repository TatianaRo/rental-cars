require 'rails_helper'

feature 'user start rental' do
    scenario 'successfully' do
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        car_category = CarCategory.create!(name: 'Top', daily_rate: 100.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')                                   
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                car_category: car_category, user: user)  

        car_model = CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                                    car_category: car_category, fuel_type:'Flex')  
        car = Car.create!(license_plate: 'ABC1234', color: 'Preto', car_model:car_model,
                          mileage: 0)                        
        login_as user, scope: :user
        click_on 'Locações'
        fill_in 'Busca de locação', with: rental.token
        click_on 'Buscar'
        click_on 'Ver Detalhes'
        click_on 'Iniciar locação'
        select "#{car_model.name} - #{car.color} - #{car.license_plate}", from: 'Carros disponíveis'
        click_on 'Iniciar'

        #TODO: Pegar o nome e a cnh do condutor, foto do carro

        expect(page.to have_content('Locação iniciada com sucesso')
        expect(page.to have_content(car.license_plate)
        expect(page.to have_content(car.color)
        expect(page.to have_content(car_model.name)
        expect(page.to have_content(user.email)
        expect(page.to have_content(costumer.email)
        expect(page.to have_content(costumer.name)
        expect(page.to have_content(costumer.document)
  

    end
end