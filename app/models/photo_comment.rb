class PhotoComment < ApplicationRecord

  belongs_to :customer
  belongs_to :photo
  
  validates :photo_comment, presence: true, length:{maximum:200}
end
