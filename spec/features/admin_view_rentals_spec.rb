require 'rails_helper'

feature 'Admin view rentals' do
    scenario 'must be logged in to view rentals' do
        visit root_path
            
        expect(page).not_to have_link('Locações')
    end 
    
    scenario 'must be logged in to view rentals list' do
        visit rentals_path
            
        expect(current_path).to eq new_user_session_path
    end  
    
    scenario 'must be logged in to view rental details' do
        car_category = CarCategory.create!(name:'A', car_insurance: 100, daily_rate: 100,
                                           third_party_insurance: 100)
        costumer = Costumer.create!(name: 'Fulano Sicrano', document:'51212958047',
                                    email: 'teste@client.com')
        user = User.create!(name: 'Lorem Ipsum', email:'lorem@gmail.com',
                            password: '12345678')
        rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                                costumer: costumer, user: user , car_category: car_category )
        visit rental_path(rental)
          
        expect(current_path).to eq new_user_session_path
    end 
    
    scenario 'successfully' do
        car_category = CarCategory.create!(name:'A', car_insurance: 100, daily_rate: 100,
            third_party_insurance: 100)
        costumer = Costumer.create!(name: 'Fulano Sicrano', document:'51212958047',
                                    email: 'teste@client.com')
        user = User.create!(name: 'Lorem Ipsum', email:'lorem@gmail.com',
                            password: '12345678')
        rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                                costumer: costumer, user: user , car_category: car_category )
        another_rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                                costumer: costumer, user: user , car_category: car_category )                        
        
        login_as(user, scope: :user)
        visit root_path
        click_on 'Locações'
    
        expect(current_path).to eq rentals_path 
        expect(page).to have_content(rental.token)
        expect(page).to have_content(another_rental.token)
    end

    xscenario 'and no rental was created' do
        user = User.create!(name: 'Lorem Ipsum', email:'lorem@gmail.com',
                            password: '12345678')                     
        
        login_as(user, scope: :user)
        visit root_path
        click_on 'Locações'
    
        expect(current_path).to eq rentals_path 
        expect(page).to have_content('Nenhuma locação criada')
    end
end
