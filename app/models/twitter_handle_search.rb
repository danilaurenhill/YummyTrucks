class TwitterHandleSearch

  def self.get_newest_tweet(handle)
    client = get_client
    food_truck_account = client.user(handle)
    most_recent_tweet = food_truck_account.status
    tweet_content = most_recent_tweet.text
    url = "http://twitter.com"+ most_recent_tweet.url.path
    {:content => tweet_content, :url => url}
  end

  #find recent tweets 
  #if the most recent tweet text contains key words

  def self.get_location_tweet(handle)
    client = get_client
    twenty_tweets = client.user_timeline(handle)
    twenty_tweets.each do |tweet|
      return tweet if tweet.text.downcase.include?(" st.")
    end
  end

  def self.get_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

end