class Place < ActiveRecord::Base
  has_many :foods, dependent: :destroy
  
  
  
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