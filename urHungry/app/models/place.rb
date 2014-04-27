class Place < ActiveRecord::Base
  has_many :foods, dependent: :destroy
  
  def update_menu
    require 'csv'
    csv_text = File.read(Rails.root.join('app', 'assets', 'menu', 'mealinfo.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Food.create!(:place_id => Place.where{name.matches row['place']}.first.id, :name => row['name'])
    end
  end
  
  def average_score
    score = 0
    foods.each do |food|
      score += food.average_score
    end
    if (foods.length > 0)
      (score / foods.length).round(1)
    else
      0.0
    end
  end
  
end