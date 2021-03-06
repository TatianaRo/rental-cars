class CarCategoriesController < ApplicationController
    before_action :authenticate_user!, only: [ :index]  

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
            #redirect_to car_category_path(id: @car_category.id)  ou redirect_to car_category_path(@car_category)  
        else 
            render :new 
            #é diferente de redirect_to new_car_category_path que só manda pra action
            #enquanto o render continua no create e roda a view do new mantendo @car_category 
        end       
                                  
    end

    def edit
        @car_category = CarCategory.find(params[:id])
    end

    def update
        @car_category = CarCategory.find(params[:id])
        if @car_category.update(car_category_params)
            redirect_to @car_category
        else
            render :edit    
        end
    end

    def destroy
        @car_category = CarCategory.find(params[:id]) 
        @car_category.destroy
        redirect_to car_categories_path
    end    

    private

    def car_category_params
       params.require(:car_category)
             .permit(:name, :daily_rate, :car_insurance, :third_party, :third_party_insurance) 
    end  

 end