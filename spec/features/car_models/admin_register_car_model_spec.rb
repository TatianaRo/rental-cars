require 'rails_helper'

feature 'Admin register car model' do
    scenario 'must be signed in' do
       
        visit root_path
        click_on 'Modelos de carro'
    
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Para continuar, efetue login ou registre-se'
    end

    scenario 'successfully' do
        car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50, 
        third_party_insurance: 20)
 
        visit root_path
        click_on 'Modelos de carro'
        click_on 'Registrar um modelo de carro'
        fill_in 'Nome', with: 'ka'
        fill_in 'Ano', with: '2019'
        fill_in 'Fabricante', with: 'Ford'
        fill_in 'Motorização', with: '1.0'
        select  'Top', from: 'Categoria de carro'
        fill_in 'Tipo de combustível', with: 'Flex'
        click_on 'Enviar'

        expect(page).to have_content('ka')
        expect(page).to have_content('2019')
        expect(page).to have_content('Ford')
        expect(page).to have_content('1.0')
        expect(page).to have_content('Top')
        expect(page).to have_content('Flex')
        
    end

    scenario 'must fill in all fields' do
        visit root_path
        click_on 'Modelos de carro'
        click_on 'Registrar um modelo de carro'
        click_on 'Enviar'

        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Ano não pode ficar em branco')
        expect(page).to have_content('Fabricante não pode ficar em branco')
        expect(page).to have_content('Motorização não pode ficar em branco')
        expect(page).to have_content('Categoria de carro é obrigatório(a)')
        expect(page).to have_content('Tipo de combustível não pode ficar em branco')
    end
end