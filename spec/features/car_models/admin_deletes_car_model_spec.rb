require 'rails_helper'

feature 'Admin deletes car model' do
  scenario 'successfully' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                        third_party_insurance: 20)
    CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                    car_category: car_category, fuel_type:'Flex')

    login_as(user, scope: user)
    visit root_path
    click_on 'Modelos de carro'  
    click_on 'ka - 2019'
    click_on 'Apagar'  
    
    expect(current_path).to eq car_models_path
    expect(page).to have_content('Nenhum modelo cadastrado')
 end

 scenario 'and keep anothers' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
                                       third_party_insurance: 20)
    CarModel.create!(name:'ka', year:2019, manufacturer:'Ford', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')
    CarModel.create!(name:'Onix', year:2020, manufacturer:'Chevrolet', motorization:'1.0',
                     car_category: car_category, fuel_type:'Flex')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'ka - 2019'
    click_on 'Apagar'

    expect(current_path).to eq car_models_path
    expect(page).not_to have_content('ka - 2019')
    expect(page).to have_content('Onix - 2020')
 end 
    
end