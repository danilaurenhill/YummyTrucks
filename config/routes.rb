Rails.application.routes.draw do
  # home page
  root to: 'static_pages#index'
  
  # to search based on a twitter handle
  post '/food_trucks/search' => 'food_trucks#search'

  get "/auth/twitter/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  post "/users/:id/tweet" => "users#tweet", :as => :user_tweet

  resources :food_trucks, :only => [:show, :index]

  # resources :birds
  # 1. get "/birds" index
  # 2. get "/birds/:id" show
  # 3. get "/birds/:id/edit" edit
  # 4. get "/birds/new" new
  # 5. post "/birds" create
  # 6. patch "/birds/:id" update
  # 7. delete "/birds/:id" destroy
end
