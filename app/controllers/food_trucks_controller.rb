class FoodTrucksController < ApplicationController
  def search
    handle = params[:twitter_handle]
    tweet = TwitterHandleSearch.get_location_tweet(handle)
    binding.pry
    # @content = info[:content]
    # @url = info[:url]
  end
end
