class StaticPagesController < ApplicationController
  def index
    @random_food_truck = FoodTruck.all.sample
    @food_trucks = FoodTruck.all
  end
end