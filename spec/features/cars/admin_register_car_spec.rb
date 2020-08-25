require 'rails_helper'

feature 'Admin register car to subsidiary' do
    scenario 'must be signed in' do
       
        visit root_path
        click_on 'Carros'
    
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Para continuar, efetue login ou registre-se'
    end

    scenario 'successfully' do
        user = User.create!(name: 'João Almeida', email:'joao@email.com', 
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
        fill_in 'Placa', with: 'FRE1234'
        fill_in 'Cor', with: 'Preto'
        select  'Ka', from: 'Modelo do Carro'
        fill_in 'Quilometragem', with: '100'
        select  'Paulista', from: 'Filial'
        click_on 'Enviar'
        
        expect(page).to have_content('FRE1234')
        expect(page).to have_content('Preto')
        expect(page).to have_content('Ka')
        expect(page).to have_content('100')
        expect(page).to have_content('Paulista')
              
    end
end