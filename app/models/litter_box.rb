class LitterBox < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true, uniqueness: true

  def self.within lat, lng, miles = 150
    lat_range = miles * 0.014492754
    lng_range = miles * 0.016666667
    where(
      latitude:  lat - lat_range .. lat + lat_range,
      longitude:  lng - lng_range .. lng + lng_range
    )
  end
end
