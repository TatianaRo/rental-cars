class CarModelsController <  ApplicationController
    before_action :authenticate_user!

    def index
        @car_models = CarModel.all
    end    

    def show
        @car_model = CarModel.find(params[:id])
    end   
    
    def new
        @car_model = CarModel.new
        @car_categories = CarCategory.all
    end    

    def create
        @car_model = CarModel.new(car_model_params)
        if @car_model.save
            redirect_to @car_model
        else
            @car_categories = CarCategory.all
            render :new    
        end
    end 

    def edit
        @car_model = CarModel.find(params[:id])
        @car_categories = CarCategory.all
    end
    
    def update
        @car_model = CarModel.find(params[:id])
        @car_categories = CarCategory.all
        if @car_model.update(car_model_params)
            redirect_to @car_model
        else
            render :edit    
        end
    end

    def destroy
        @car_model = CarModel.find(params[:id])
        @car_model.destroy
        redirect_to car_models_path
    end    
    
    
    private

    def car_model_params
        params.require(:car_model)
              .permit(:name, :year, :manufacturer, :motorization, :car_category_id, :fuel_type)
    end    

end