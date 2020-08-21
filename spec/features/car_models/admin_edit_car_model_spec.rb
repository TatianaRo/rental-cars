require 'rails_helper'

feature 'Admin edits car category' do
    scenario 'successfully' do
      user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                            password: '12345678')
      car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                         third_party_insurance: 20)
      CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                       car_category: car_category, fuel_type:'Flex')
      
                
      login_as(user, scope: :user) 

      visit root_path
      click_on 'Modelos de carro'
      click_on 'ka - 2019'
      click_on 'Editar'
      fill_in 'Nome', with: 'Onix'
      fill_in 'Ano', with: '2020'
      fill_in 'Fabricante', with: 'Chevrolet'
      fill_in 'Motorização', with: '1.0'
      select  'Top', from: 'Categoria de carro'
      fill_in 'Tipo de combustível', with: 'Flex'
      click_on 'Enviar'  
  
      expect(page).to have_content('Onix')
      expect(page).not_to have_content('ka')
      expect(page).to have_content('2020')
      expect(page).to have_content('Chevrolet')
      expect(page).to have_content('Flex')
    end

    scenario 'attributes cannot be blank' do
      user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                          password: '12345678')
      car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                         third_party_insurance: 20)   
      CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                       car_category: car_category, fuel_type:'Flex')
      
                
      login_as(user, scope: :user)                     
  
      visit root_path
      click_on 'Modelos de carro'
      click_on 'ka - 2019'
      click_on 'Editar'
      fill_in 'Nome', with: ''
      fill_in 'Ano', with: ''
      fill_in 'Fabricante', with: ''
      fill_in 'Motorização', with: ''
      select  '', from: 'Categoria de carro'
      fill_in 'Tipo de combustível', with: ''
      click_on 'Enviar'
      
      expect(page).to have_content('não pode ficar em branco', count: 5)
    end

end  
  
   