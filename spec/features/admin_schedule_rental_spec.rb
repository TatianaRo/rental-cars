require 'rails_helper'

feature 'Admin schedule rental' do
    scenario 'successfully' do
        CarCategory.create!(name:'A', car_insurance: 100, daily_rate: 100,
                            third_party_insurance: 100)
        Costumer.create!(name: 'Fulano Sicrano', document:'51212958047',
                       email: 'teste@client.com')
        user = User.create!(name: 'Lorem Ipsum', email:'lorem@gmail.com',
                            password: '12345678')
        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        click_on 'Agendar nova locação'
        fill_in 'Data de início', with: '21/08/2030'
        fill_in 'Data de término', with: '23/08/2030' 
        select 'Fulano Sicrano - 51212958047', from: 'Cliente'
        select 'A', from: 'Categoria de carro'
        click_on 'Agendar'
        
        expect(page).to have_content('21/08/2030')
        expect(page).to have_content('23/08/2030')
        expect(page).to have_content('Fulano Sicrano')
        expect(page).to have_content('51212958047')
        expect(page).to have_content('A')
        expect(page).to have_content('R$ 600,00')
        expect(page).to have_content('Agendamento realizado com sucesso')

    end

    scenario 'must fill in all fields' do
        user = User.create!(name: 'Lorem Ipsum', email:'lorem@gmail.com',
                            password: '12345678')
        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        click_on 'Agendar nova locação'
        fill_in 'Data de início', with: ''
        fill_in 'Data de término', with: '' 
        click_on 'Agendar'

        expect(Rental.count).to eq 0
        expect(page).to have_content('não pode ficar em branco', count: 2)
        expect(page).to have_content('é obrigatório(a)', count: 2)
    end

        
    scenario 'must be logged in to view rental details' do
        visit new_rental_path

        expect(current_path).to eq new_user_session_path
    end    

end