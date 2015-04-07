class CreateFoodTrucks < ActiveRecord::Migration
  def change
    create_table :food_trucks do |t|
      t.string :name
      t.string :handle
      t.text :description
      t.integer :twitter_id
      t.string :website
      t.string :handle
      t.string :image_url
      t.timestamps null: false
    end
  end
end
