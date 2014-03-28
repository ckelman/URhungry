class Food < ActiveRecord::Base
  belongs_to :place
  has_many :reviews, dependent: :destroy
end
