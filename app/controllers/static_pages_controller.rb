class StaticPagesController < ApplicationController
  def index
    @random_food_truck = FoodTruck.all.sample
  end
  
end