class CarCategoriesController < ApplicationController

    def index
        @car_categories = CarCategory.all 
    end

    def show
        @car_category = CarCategory.find(params[:id])   
    end

    def new
        @car_category =  CarCategory.new
    end    

    def create
        @car_category = CarCategory.new(car_category_params)
        if @car_category.save
            redirect_to @car_category 
        else 
            render :new # é difernte de redirect_to new_car_category_path que só manda pra action enquanto o render continua no create e roda a view do new mantendo @car_category 
        end
        #alternativa persistend?         
        #redirect_to car_category_path(id: @car_category.id)  ou redirect_to car_category_path(@car_category)                           
    end

    private

    def car_category_params
       params.require(:car_category)
             .permit(:name, :daily_rate, :car_insurance, :third_party, :third_party_insurance) 
    end  

 end