require 'rails_helper'

feature 'Admin register valid car' do

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')

    login_as(user, scope: :user) 

    visit root_path
    click_on 'Carros'
    click_on 'Registrar um novo carro para a frota'
    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    fill_in 'Quilometragem', with: ''
    click_on 'Enviar'

    expect(Car.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
  
  scenario 'and license plate must be unique' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
      password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    car_model = CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')  
    subsidiary = Subsidiary.create!(name:'Paulista', cnpj:'42495186000147', address:'Paulista, 1200') 
    Car.create!(license_plate: 'ABC1234', color:'preto', car_model: car_model,
                mileage: 0, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Registrar um novo carro para a frota'
    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Cor', with: 'Preto'
    select  'Ka', from: 'Modelo'
    fill_in 'Quilometragem', with: '100'
    select  'Paulista', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and mileage must be above or equal 0' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
      password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    CarModel.create!(name:'Ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')  
    Subsidiary.create!(name:'Paulista', cnpj:'42495186000147', address:'Paulista, 1200') 
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Registrar um novo carro para a frota'
    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Cor', with: 'Preto'
    select  'Ka', from: 'Modelo'
    fill_in 'Quilometragem', with: '-10'
    select  'Paulista', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Quilometragem deve ser maior ou igual a 0')
  end
  
end
