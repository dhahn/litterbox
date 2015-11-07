class Unavailability < ActiveRecord::Base
  belongs_to :litter_box
  validates :litter_box_id, presence: true, uniqueness: true
end
