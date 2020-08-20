def user_login()
    #Arrange
    User.create!(name: 'João Almeida', email:'joao@email.com', 
        password: '12345678')

    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: "joao@email.com"
    fill_in 'Senha', with: "12345678"
    click_on 'Entrar'
end    