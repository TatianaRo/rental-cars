require 'rails_helper'

feature 'Admin register costumer' do
  scenario 'must be signed in' do
     
    visit root_path
    click_on 'Clientes'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, efetue login ou registre-se'
  end

   scenario 'from index page' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')

    login_as(user, scope: :user) 

    visit root_path
    click_on 'Clientes'

    expect(page).to have_link('Registrar um novo cliente',
                              href: new_costumer_path)
  end

  scenario 'successfully' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
        password: '12345678')

    login_as(user, scope: :user) 
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'

    fill_in 'Nome', with: 'Matheus Lima'
    fill_in 'CPF', with: '72778632085'
    fill_in 'Email', with: 'matheus@email.com'
    click_on 'Enviar'

    expect(current_path).to eq costumer_path(Costumer.last)
    expect(page).to have_content('Matheus Lima')
    expect(page).to have_content('72778632085')
    expect(page).to have_content('matheus@email.com')
    expect(page).to have_link('Voltar')  
  end

end