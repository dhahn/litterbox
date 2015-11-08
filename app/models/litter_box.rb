class LitterBox < ActiveRecord::Base
  attr_accessor :distance
  belongs_to :user
  has_many :transactions
  has_many :unavailabilities, inverse_of: :litter_box
  accepts_nested_attributes_for :unavailabilities, allow_destroy: true

  validates :user_id, presence: true, uniqueness: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :capacity, :presence => true, :numericality => {:greater_than => 0}

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment :photo, size: { in: 0..500.kilobytes }

  def self.search(params)
    available(convert_date(params[:start_date]), convert_date(params[:end_date]))
      .within(params[:lat].to_f, params[:lng].to_f, params[:radius].to_i)
  end

  def self.available(start_time, end_time)
    where.not(id: unavailable(start_time, end_time))
  end

  def self.unavailable(start_time, end_time)
    joins(:transactions).merge(Transaction.overlaps(start_time, end_time)) +
    joins(:unavailabilities).merge(Unavailability.overlaps(start_time, end_time))
  end

  def self.within lat, lng, miles = 100
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
    hash.merge!(photo_url: photo.url)
  end

  private
    def self.convert_date(date_string)
      DateTime.strptime(date_string, '%m/%d/%Y') unless date_string.blank?
    end

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
