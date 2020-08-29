require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers 

feature 'user start rental' do
    scenario 'view only category cars' do
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')  
        
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        subsidiary = Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

        car_category_a = CarCategory.create!(name: 'A', daily_rate: 100.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        car_model_ka = CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                                        car_category: car_category_a, fuel_type:'Flex')                               
        car_category_b = CarCategory.create!(name: 'B', daily_rate: 100.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        car_model_fusion = CarModel.create!(name:'Fusion', year:2020, manufacturer:'Ford', motorization:'2.2',
                                        car_category: car_category_b, fuel_type:'Elétrico') 
        ka_car = Car.create!(license_plate: 'ABC1234', color: 'Azul', car_model:car_model_ka,
                          mileage: 0, subsidiary: subsidiary, status:'available')
        another_ka_car = Car.create!(license_plate: 'DEF5678', color: 'Vermelho', car_model:car_model_ka,
                             mileage: 0, subsidiary: subsidiary, status:'available')
        fusion_car = Car.create!(license_plate: 'GHI9012', color: 'Preto', car_model:car_model_fusion,
                             mileage: 0, subsidiary: subsidiary, status:'available')
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                               car_category: car_category_a, user: user)                                                    
      

                              
        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: rental.token
        click_on 'Buscar'
        click_on 'Ver detalhes'
        click_on 'Iniciar locação'
        
        expect(page).to have_content('ka')
        expect(page).to have_content('Azul')
        expect(page).to have_content('ABC123')

        expect(page).to have_content('Vermelho')
        expect(page).to have_content('DEF5678')

        expect(page).not_to have_content('Fusion')
        expect(page).not_to have_content('Preto')
        expect(page).not_to have_content('GHI9012')
    end

    scenario 'view only availables cars' do
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')  
        
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        subsidiary = Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

        car_category_a = CarCategory.create!(name: 'A', daily_rate: 100.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        car_model_ka = CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                                        car_category: car_category_a, fuel_type:'Flex')
        car_model_onix = CarModel.create!(name:'Onix', year:2018, manufacturer:'Ford', motorization:'1.0',
                                        car_category: car_category_a, fuel_type:'Gasolina')                               
         
        ka_car = Car.create!(license_plate: 'ABC1234', color: 'Azul', car_model:car_model_ka,
                          mileage: 0, subsidiary: subsidiary, status:'available')
        onix_car = Car.create!(license_plate: 'DEF5678', color: 'Preto', car_model:car_model_onix,
                             mileage: 0, subsidiary: subsidiary, status:'available')
        unavailable_ka_car = Car.create!(license_plate: 'GHI9012', color: 'Vermelho', car_model:car_model_ka,
                                         mileage: 0, subsidiary: subsidiary, status: 'rented')

        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                               car_category: car_category_a, user: user)                                                    
      

                              
        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: rental.token
        click_on 'Buscar'
        click_on 'Ver detalhes'
        click_on 'Iniciar locação'
        
        expect(page).to have_content('ka')
        expect(page).to have_content('Azul')
        expect(page).to have_content('ABC123')
        
        expect(page).to have_content('Onix')
        expect(page).to have_content('Preto')
        expect(page).to have_content('DEF5678')

        expect(page).not_to have_content('Vermelho')
        expect(page).not_to have_content('GHI9012')
    end


    scenario 'successfully' do
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano') 

        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')

        subsidiary = Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

        car_category = CarCategory.create!(name: 'Top', daily_rate: 100.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
                                        
        car_model = CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                                    car_category: car_category, fuel_type:'Flex')  
        car = Car.create!(license_plate: 'ABC1234', color: 'Preto', car_model:car_model,
                          mileage: 0, subsidiary: subsidiary, status:'available')  
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                car_category: car_category, user: user) 

        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: rental.token
        click_on 'Buscar'
        click_on 'Ver detalhes'
        click_on 'Iniciar locação'
        select "#{car_model.name} - #{car.color} - #{car.license_plate}", from: 'Carros disponíveis'
        fill_in 'CNH do condutor', with: 'RJ200100-10'
        travel_to Time.zone.local(2020, 10, 01, 12, 30, 45) do
          click_on 'Iniciar'       
        end
        

        #TODO: Pegar o nome e a cnh do condutor, foto do carro
        
        expect(page).to have_content(car_category.name)
        expect(page).to have_content(user.email)
        expect(page).to have_content(costumer.email)
        expect(page).to have_content(costumer.name)
        expect(page).to have_content(costumer.document)

        expect(page).to have_content('Locação iniciada com sucesso')
        expect(page).to have_content(car_model.name)
        expect(page).to have_content(car.license_plate)
        expect(page).to have_content(car.color)
        expect(page).to have_content('RJ200100-10')
        expect(page).not_to have_link('Iniciar Locação')
        expect(page).to have_content('01 de outubro de 2020, 12:30:45')
   end

   xscenario 'and car status changes after be rented' do
        user = User.create!(email:'newuser@email.com', password: '12345678', name: 'Sicrano') 

        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'58119988051')

        subsidiary = Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

        car_category = CarCategory.create!(name: 'Top', daily_rate: 100.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
                                        
        ka_car_model = CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                                    car_category: car_category, fuel_type:'Flex') 
        onix_car_model = CarModel.create!(name:'Onix', year:2019, manufacturer:'Ford', motorization:'1.0',
                                    car_category: car_category, fuel_type:'Flex') 
        car = Car.create!(license_plate: 'ABC1234', color: 'Preto', car_model: ka_car_model,
                          mileage: 0, subsidiary: subsidiary, status:'available') 
        rented_car = Car.create!(license_plate: 'DEF5678', color: 'Vermelho', car_model:onix_car_model,
                          mileage: 0, subsidiary: subsidiary, status:'available')  
        rental_a = Rental.create!(start_date: Date.current, end_date: 5.day.from_now, costumer: costumer,car_category: car_category, user: user) 
        car_rental = CarRental.create!(rental: rental_a, car: rented_car, user:user, start_date: 1.day.from_now,
                                       driver_license_number: 'RJ200100-10')
        rental_b = Rental.create!(start_date: Date.current, end_date: 5.day.from_now, costumer: costumer,
                                car_category: car_category, user: user)  
       
        
        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: rental_b.token
        click_on 'Buscar'
        click_on 'Ver detalhes'
        click_on 'Iniciar locação'
        
        expect(page).not_to have_content('Onix')
        expect(page).not_to have_content('DEF5678')
        expect(page).not_to have_content('Vermelho')
   end
end