class Review < ActiveRecord::Base
 
  attr_accessible :content, :rating, :reviewer_id, :wine_id

  belongs_to :wine
  belongs_to :reviewer, class_name: "User"

  validates :content, :reviewer_id, :wine_id, presence: true
  validates :content, length: { minimum: 6}

end
