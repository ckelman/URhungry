class Place < ActiveRecord::Base
  has_many :foods, dependent: :destroy
  
  
  
  def average_score
    score = 0
    tot = 0
    foods.each do |food|
      score += food.average_score
      if(food.reviews.length > 0)
        tot+=1
      end
    end
    if (foods.length > 0)
      (score / tot).round(1)
    else
      0.0
    end
  end
  
end