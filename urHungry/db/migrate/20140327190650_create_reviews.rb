class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.decimal :rating
      t.integer :user_id
      t.integer :food_id

      t.timestamps
    end
  end
end
