class FoodTruck < ActiveRecord::Base
  before_save :downcase_handle
  validates :handle, :uniqueness => true, :presence => true

  DESIRABLE_WORDS = [" ave ", " ave.", "avenue", "st.", " st ", "street", "ln", "lane", " sq ", " & ", "Bway", "square"]
  REGEXES = [/\dst /, /\dnd/, /\drd/, /\dth /]
  UNDESIRABLE_WORDS = ["street food", "street cart", "@square"]
 
  def self.get_newest_tweet(handle)
    client = get_client
    food_truck_account = client.user(handle)
    food_truck_account.status
  end

  def self.add_truck_to_database(twitter_handle)
    client = get_client
    info = client.user(twitter_handle)
    food_truck = FoodTruck.new
    food_truck.description = info.description
    food_truck.twitter_id = info.id
    food_truck.website = info.website_uris[0].attrs[:expanded_url]
    food_truck.name = info.name
    food_truck.handle = info.screen_name
    food_truck.image_url = "http://pbs.twimg.com" + info.profile_image_uri.path
    food_truck.save
    food_truck
  end
    
  def self.get_location_tweet(handle)
    client = get_client
    twenty_tweets = client.user_timeline(handle)
    twenty_tweets.each do |tweet|
      has_address = false
      DESIRABLE_WORDS.each do |keyword|
        has_address = true if tweet.text.downcase.include?(keyword) 
      end
      REGEXES.each do |regex|
        has_address = true if tweet.text.downcase =~ regex 
      end
      if has_address && verify_address?(tweet)
        return tweet
      end
    end
    return nil
  end

  def self.verify_address?(tweet)
    UNDESIRABLE_WORDS.each do |word|
      return false if tweet.text.downcase.include?(word)
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

  private

  def downcase_handle
    self.handle = self.handle.downcase
  end
end
