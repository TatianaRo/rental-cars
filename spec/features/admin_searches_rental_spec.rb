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

    scenario 'and finds nothing' do
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')                                   
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                car_category: car_category, user: user)
        rental.update(token: 'ABC123')                        
        another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                        car_category: car_category, user: user)   
        another_rental.update(token: 'ABC567')
        
        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: 'CDF'
        click_on 'Buscar'

        expect(page).not_to have_content(rental.token)
        expect(page).not_to have_content(another_rental.token)
    end    

    scenario 'and finds by partial token' do
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')                                   
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                car_category: car_category, user: user)
        rental.update(token: 'ABC123')                        
        another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                        car_category: car_category, user: user)   
        another_rental.update(token: 'ABC567')
        rental_not_to_be_found = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
            car_category: car_category, user: user)                                                    
        rental_not_to_be_found.update(token: '098098')

        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: 'ABC'
        click_on 'Buscar'

        expect(page).to have_content(rental.token)
        expect(page).to have_content(another_rental.token)
        expect(page).not_to have_content(rental_not_to_be_found.token)
    end  
    
    scenario 'and finds by costumer name' do
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        another_costumer = Costumer.create!(name:'Beltrano Marlando', email:'fulano@email.com', document:'69498424063')
        car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')                                   
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                car_category: car_category, user: user)
                          
        another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                        car_category: car_category, user: user)   
      
        rental_not_to_be_found = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: another_costumer,
                                                car_category: car_category, user: user)                                                    

        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: 'Fulano Sicrano'
        click_on 'Buscar'

        expect(page).to have_content(rental.token)
        expect(page).to have_content(another_rental.token)
        expect(page).not_to have_content(rental_not_to_be_found.token)
    end  

    scenario 'and finds by costumer document' do
        costumer = Costumer.create!(name:'Fulano Sicrano', email:'fulano@email.com', document:'31406031003')
        another_costumer = Costumer.create!(name:'Beltrano Marlando', email:'fulano@email.com', document:'69498424063')
        car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                           third_party_insurance: 10.5)
        user = User.create!(email:'user@email.com', password: '12345678', name: 'Sicrano')                                   
        rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                car_category: car_category, user: user)
                          
        another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: costumer,
                                        car_category: car_category, user: user)   
      
        rental_not_to_be_found = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, costumer: another_costumer,
                                                car_category: car_category, user: user)                                                    

        login_as user, scope: :user
        visit root_path
        click_on 'Locações'
        fill_in 'Busca de locação', with: '31406031003'
        click_on 'Buscar'

        expect(page).to have_content(rental.token)
        expect(page).to have_content(another_rental.token)
        expect(page).not_to have_content(rental_not_to_be_found.token)
    end  
end