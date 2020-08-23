require 'rails_helper'

feature 'Admin register valid car category' do

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')

    login_as(user, scope: :user) 
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(Costumer.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
  
  scenario 'and CPF must be unique' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')

    Costumer.create!(name: 'Mario', document:'38590583040', email:'mario@email.com')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: 'Rosangela'
    fill_in 'CPF', with: '38590583040'
    fill_in 'Email', with: 'ro@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and CPF must be valid' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: 'Rosangela'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Email', with: 'ro@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('inválido')
  end

  scenario ' and CPF length must be 11' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: 'Rosangela'
    fill_in 'CPF', with: '658171010504545454'
    fill_in 'Email', with: 'ro@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('não possui o tamanho esperado (11 caracteres)')
  end

  
end
