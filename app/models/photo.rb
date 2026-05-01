class Photo < ApplicationRecord
  belongs_to :plot
  has_one_attached :image

  acts_as_list scope: :plot
end
