class Food < ActiveRecord::Base
  belongs_to :place
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  
  # def average_rating
    # if ratings.size > 0
      # ratings.sum(:score) / ratings.size
    # else
      # 0
    # end
  # end
  
  def average_score
    if reviews.size > 0
      (reviews.sum(:rating) / reviews.size).round(1)
    else
      0.0
    end
  end
end
