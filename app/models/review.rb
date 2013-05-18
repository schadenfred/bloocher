class Review < ActiveRecord::Base
 
  attr_accessible :content, :rating, :reviewer_id, :wine_id

  attr_accessor :blooch 

  belongs_to :wine
  belongs_to :reviewer, class_name: "User"

  validates :reviewer_id, :wine_id, presence: true
  # validates :content, length: { minimum: 6}
  validates :wine_id, numericality: true

end
