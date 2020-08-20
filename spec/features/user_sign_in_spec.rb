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
        fill_in 'Senha', with: "12345678"
        click_on 'Entrar'


        #Assert
        expect(page).to have_content 'João Almeida'
        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_link 'Entrar'
        
    end

    scenario 'and sign out' do
        user = User.create!(name: 'João Almeida', email:'joao@email.com', 
            password: '12345678')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Sair'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Saiu com sucesso.'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_link 'Sair'
                
    end
end

