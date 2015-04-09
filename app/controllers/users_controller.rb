class UsersController < ApplicationController

  def tweet
    @user = User.find(params[:id])
    @food_truck = FoodTruck.find(truck_params[:id])
    content = tweet_params[:tweet_content]
    @tweet = @user.tweet("@#{@food_truck.handle} #{content}")
    flash[:notice] = "You tweeted at @#{@food_truck.handle}."
    flash[:link] = "http://twitter.com/#{@tweet.url.path}"
    redirect_to food_truck_path(@food_truck)
  end

  private

  def tweet_params
    params.require(:user).permit(:tweet_content)
  end

  def truck_params
    params.require(:food_truck).permit(:id)
  end
  
end
