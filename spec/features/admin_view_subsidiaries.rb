require 'rails_helper'

feature 'Admin view subsidiares' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')
    Subsidiary.create!(name: 'Filial10', cnpj: '71510275000113', address: 'Rua São João, 1020')
    
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq subsidiaries_path #Verfica se foi para nova rota
    expect(page).to have_content('Filial00')
    expect(page).to have_content('Filial10')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')
    Subsidiary.create!(name: 'Filial10', cnpj: '71510275000113', address: 'Rua São João, 1020')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial00'

    expect(page).to have_content('Filial00')
    expect(page).to have_content('68843380000160')
    expect(page).to have_content('Rua das Aves, 302')
    expect(page).not_to have_content('Filial10')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end
  
  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

    visit root_path
    click_on 'Filiais'
    click_on 'Filial00'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end

  
end
