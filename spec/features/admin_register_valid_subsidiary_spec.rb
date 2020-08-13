require 'rails_helper'  

feature 'Admin register valid subsidiary' do

    scenario 'and attributes cannot be blank' do
      visit root_path
      click_on 'Filiais'
      click_on 'Registrar uma nova filial'
      fill_in 'Nome', with: ''
      fill_in 'CNPJ', with: ''
      fill_in 'Endereço', with: ''
      click_on 'Enviar'
  
      expect(Subsidiary.count).to eq 0
      expect(page).to have_content('não pode ficar em branco', count: 3)
    end

    scenario 'and cnpj must be unique' do
        Subsidiary.create!(name: 'Filial10', cnpj: '71717095000107', address:'Rua das aves,200')
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar uma nova filial'
        fill_in 'Nome', with: 'Filial10'
        fill_in 'CNPJ', with: '71717095000107'
        fill_in 'Endereço', with: 'Rua das aves,200'
        click_on 'Enviar'

        expect(page).to have_content('já está em uso')
    end

    scenario 'and cnpj length must be 14' do
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar uma nova filial'
        fill_in 'Nome', with: 'Filial10'
        fill_in 'CNPJ', with: '222'
        fill_in 'Endereço', with: 'Rua das aves,200'
        click_on 'Enviar'

        expect(page).to have_content('Cnpj não possui o tamanho esperado (14 caracteres)')
    end

    scenario 'and cnpj must be valide' do
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar uma nova filial'
        fill_in 'Nome', with: 'Filial10'
        fill_in 'CNPJ', with: '2222222222222'
        fill_in 'Endereço', with: 'Rua das aves,200'
        click_on 'Enviar'

        expect(page).to have_content('inválido')
    end
end