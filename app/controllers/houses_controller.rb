class HousesController < ApplicationController

    # Reject any requrests if user is not authenticated
    before_action :authenticate_user!
    before_action :set_house, only: [:show, :update]
    
    # GET /houses or houses.json
    def index
        category = params[:category]
        search = params[:search]

        @houses = House
            .where("category LIKE '%#{category}%' AND title LIKE '%#{search}%'")
            .order(created_at: :desc)
        
            render json: @houses
    end

    # GET /houses/own or /houses/own.json
    def own
        @houses = House.where(user_id: authenticate_user!.id)
            .order(created_at: :desc)
        render json: @houses
    end

    # POST /houses/1 or /houses/1.json
    def show
        if @house
            render json: @house
        else
            render json: nil, status: :unauthorized
        end
    end

    # POST /houses or /houses.json
    def create
        @house = House.new(house_params)
        @house.update_attribute(:user_id, authenticate_user!.id)
        @house.save

        render json: @house
    end

    # PATCH /houses/1 or /houses/1.json
    def update
        if @house
            @house.update(house_params)
            render json: @house
        else
            render json: nil, status: :unauthorized
        end
    end

    private
    def set_house
        @house = House.find(user_id: authenticate_user!, id: params[:id])
    end

    def house_params
        params.require(:house).permit(:title, :description, :category, :address, :image,
            :price, :bedroom, :bathroom, :car)
    end
end