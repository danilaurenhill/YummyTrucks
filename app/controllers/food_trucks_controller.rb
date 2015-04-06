class FoodTrucksController < ApplicationController
  def search
    handle = params[:twitter_handle]
    info = TwitterHandleSearch.get_location(handle)
    @content = info[:content]
    @url = info[:url]
  end
end
