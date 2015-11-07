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

    litterboxes.select { |litterbox| litterbox.calc_distance(lat, lng) < miles }.sort_by(&:distance)
  end

  def calc_distance lat, lng
    self.distance = haversine_distance(lat, lng)
  end

  def full_address
    "#{address_line_1} #{address_line_2}, #{city}, #{state} #{zip}"
  end

  def as_json(*args)
    hash = super(*args)
    hash.merge!(distance: distance)
    hash.merge!(full_address: full_address)
  end

  private
    #totes ripped this from someone smarter than me
    def haversine_distance(lat1, long1)
      lat2 = self.latitude
      long2 = self.longitude
      dtor = Math::PI/180
      r = 3959

      rlat1 = lat1 * dtor
      rlong1 = long1 * dtor
      rlat2 = lat2 * dtor
      rlong2 = long2 * dtor

      dlon = rlong1 - rlong2
      dlat = rlat1 - rlat2

      a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      d = r * c

      return d
    end

    def power(num, pow)
      num ** pow
    end
end
