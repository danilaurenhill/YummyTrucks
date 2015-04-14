class FoodTrucksController < ApplicationController
  before_action :set_food_truck, only: [:show]

  def search
   handle = search_params[:handle].downcase  
   if FoodTruck.valid_handle?(handle)
     @food_truck = FoodTruck.find_by(:handle => handle) 
     @food_truck ||= FoodTruck.add_truck_to_database(handle)
     redirect_to food_truck_path(@food_truck)
   else
     flash[:notice] = "That's not a valid Twitter handle man! Try again."
     redirect_to root_url
   end
 end

  def show
    @food_truck = FoodTruck.find(params[:id])
    @tweet = FoodTruck.get_location_tweet(@food_truck.handle)
    if @tweet.nil?
      @tweet = FoodTruck.get_newest_tweet(@food_truck.handle)
      flash[:notice] = "Sorry, we couldn't find a location for that food truck. Here's the truck's most recent Tweet instead."
    end
  end

  def index
    @food_trucks = FoodTruck.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_truck
      @food_truck = FoodTruck.find(params[:id])
    end

    def search_params
      params.permit(:handle)
    end

end
