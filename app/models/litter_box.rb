class LitterBox < ActiveRecord::Base
  attr_accessor :distance
  belongs_to :user
  has_many :transactions

  validates :user_id, presence: true, uniqueness: true

  def self.within lat, lng, miles = 150
    lat_range = miles * 0.014492754
    lng_range = miles * 0.016666667

    litterboxes = where(
      latitude:  lat - lat_range .. lat + lat_range,
      longitude:  lng - lng_range .. lng + lng_range
    )

    litterboxes.select { |litterbox| litterbox.calc_distance(lat, lng) < miles }
  end

  def calc_distance lat, lng
    #do some funky stuff
    self.distance = 150
  end

  def full_address
    "#{address_line_1} #{address_line_2}, #{city}, #{state} #{zip}"
  end

  def as_json(*args)
    hash = super(*args)
    hash.merge!(distance: distance)
    hash.merge!(full_address: full_address)
  end
end
