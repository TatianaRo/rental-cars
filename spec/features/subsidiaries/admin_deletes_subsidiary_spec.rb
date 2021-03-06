require 'rails_helper'

feature 'Admin deletes subsidiary' do
  scenario 'successfully' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')
   
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Filial00'
    click_on 'Apagar'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and keep anothers' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana@email.com', 
                        password: '12345678')
       
    Subsidiary.create!(name: 'Filial00', cnpj: '68843380000160', address: 'Rua das Aves, 302')
    Subsidiary.create!(name: 'Filial10', cnpj: '71510275000113', address: 'Rua São João, 1020')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Filial00'
    click_on 'Apagar'

    expect(current_path).to eq subsidiaries_path
    expect(page).not_to have_content('Filial00')
    expect(page).to have_content('Filial10')
  end
end