class FoodTrucksController < ApplicationController
  def search
    handle = params[:twitter_handle]
    @tweet = TwitterHandleSearch.get_location_tweet(handle)
    if @tweet.nil?
      @tweet = TwitterHandleSearch.get_newest_tweet(handle)
      flash[:notice] = "Sorry, we couldn't find a location for that food truck. Here's the truck's most recent Tweet instead."
    end
  end
end
