require 'rails_helper'

feature 'User sign in' do
    
    # objetivo: a partir da tela inicial, ir para tela de login
    scenario 'from home page' do
        #Arrange

        #Act
        visit root_path

        #Assert
        expect(page).to have_link('Entrar')

    end

    scenario 'successfully' do
        #Arrange
        User.create!(name: 'João Almeida', email:'joao@email.com', 
                     password: '12345678')

        #Act
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: "joao@email.com"
        fill_in 'Email', with: "joao@email.com"
        click_on 'Entrar'


        #Assert
        expect(page).to have_content 'João Almeida'
        expect(page).to have_content 'Usuário Autenticado'
        expect(page).to have_Link 'Sair'
        expect(page).not_to have_Link 'Entrar'
        
    end

    xscenario 'and sign out' do
        user = User.create!(name: 'João Almeida', email:'joao@email.com', 
            password: '12345678')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Sair'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Saiu com sucesso.'
        expect(page).to have_content 'Entrar'
        expect(page).not_to have_content 'Sair'
                
    end
end

