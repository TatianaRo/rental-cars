require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')
  
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')
    
    login_as(user, scope: :user) 
    visit root_path
    click_on 'Filiais'
    click_on 'Filial00'
    click_on 'Editar'
    fill_in 'Nome', with: 'Filial10'
    fill_in 'CNPJ', with: '71510275000113'
    fill_in 'Endereço', with: 'Rua das Aves, 302'
    click_on 'Enviar'

    expect(page).to have_content('Filial10')
    expect(page).not_to have_content('Filial00')
    expect(page).to have_content('71510275000113')
    expect(page).to have_content('Rua das Aves, 302')
  end

  scenario 'attributes cannot be blank' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')

    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

    login_as(user, scope: :user)   
    visit root_path
    click_on 'Filiais'
    click_on 'Filial00'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'cnpj must be unique' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')
   
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')
    Subsidiary.create!(name: 'Filial10', cnpj: '71510275000113', address: 'Rua São João, 1020')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Filial00'
    click_on 'Editar'
    fill_in 'CNPJ', with: '71510275000113'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
end
