class CarRentalsController <  ApplicationController    
    def new
        @rental = Rental.find(params[:rental_id])
        @availables_cars = Car.where(car_model: @rental.car_category.car_models).where(status: 0)
        @car_rental = CarRental.new
    end

    def create 
      @rental = Rental.find(params[:rental_id])
      @car_rental = @rental.build_car_rental(car_rental_params)
      #atualizando o status do carro
      @car_rental.car.status = 'rented'
      ##############################
      @car_rental.save
      redirect_to @rental, notice: 'Locação iniciada com sucesso'
    end
    
    private 

    def car_rental_params
      params.require(:car_rental).permit(:car_id, :driver_license_number)
            .merge(user_id: current_user.id, start_date: Time.zone.now )
    end  
end    
