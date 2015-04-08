class FoodTrucksController < ApplicationController
  before_action :set_food_truck, only: [:show]

  def search
    handle = params[:twitter_handle]
    @tweet = TwitterHandleSearch.get_location_tweet(handle)
    if @tweet.nil?
      @tweet = TwitterHandleSearch.get_newest_tweet(handle)
      flash[:notice] = "Sorry, we couldn't find a location for that food truck. Here's the truck's most recent Tweet instead."
    end
  end

  def show
    @random_food_truck = FoodTruck.all.sample
    @tweet = TwitterHandleSearch.get_location_tweet(@random_food_truck.handle)
    if @tweet.nil?
      @tweet = TwitterHandleSearch.get_newest_tweet(@random_food_truck.handle)
      flash[:notice] = "Sorry, we couldn't find a location for that food truck. Here's the truck's most recent Tweet instead."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_truck
      @food_truck = FoodTruck.find(params[:id])
    end

end
