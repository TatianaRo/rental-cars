require 'rails_helper'

feature 'Admin registers subsidiaries' do 
   

  scenario 'from index page' do 
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana01@email.com', 
    password: '12345678')
    login_as(user, scope: :user)   

    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar uma nova filial',
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    user = User.create!(name: 'Tatiana Oliveira', email:'tatiana01@email.com', 
                        password: '12345678')
    login_as(user, scope: :user)   
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    fill_in 'Nome', with: 'Filial02'
    fill_in 'CNPJ', with: '71717095000107'
    fill_in 'Endereço', with: 'Rua macarena, 89'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Filial02')
    expect(page).to have_content('71717095000107')
    expect(page).to have_content('Rua macarena, 89')
    expect(page).to have_link('Voltar')
  end  

end