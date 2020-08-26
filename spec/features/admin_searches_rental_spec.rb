require 'rails_helper'

feature 'Admin searches rental' do
    scenario 'and find exact match' do
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')                                   
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                            car_category: car_category, user: user)
        another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                    car_category: car_category, user: user)                    

        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: rental.token
        click_on 'Buscar'

        expect(page).to have_content(rental.token)
        expect(page).not_to have_content(another_rental.token)
        expect(page).to have_content(rental.costumer.name)
        expect(page).to have_content(rental.costumer.email)
        expect(page).to have_content(rental.costumer.document)
        expect(page).to have_content(rental.user.email)
        expect(page).to have_content(rental.car_category.name)
    end
end