class LitterBox < ActiveRecord::Base
  STOCK_PHOTOS = [
    'http://img-cdn1.iha.co.nz/2209300015704/Guest-house-bed-and-breakfast-San-pedro-Cedar-Cats_15.jpeg',
    'https://upload.wikimedia.org/wikipedia/commons/e/e6/Nekokaigi,_a_cat_cafe_in_Kyoto_-_March_16,_2010.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Socks_the_Cat_Explores.jpg/1024px-Socks_the_Cat_Explores.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/9b/Rabbit_condo.jpg',
    'http://upload.wikimedia.org/wikipedia/commons/e/e4/Trent_Park_House_-_geograph.org.uk_-_71113.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/9b/Pink_lady_in_eureka.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/6/6c/Stephenking_house.JPG',
    'https://upload.wikimedia.org/wikipedia/commons/8/82/Hotel_Jerome,_Aspen,_CO.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/3/3c/Basement_of_Lawang_Sewu_2011.JPG',
    'https://upload.wikimedia.org/wikipedia/commons/d/d3/Homo_floresiensis_cave.jpg',
    'https://c2.staticflickr.com/4/3205/2955956036_cc422e1af8.jpg',
    'http://towson.shownbyphotos.com/imgs/20060818-towson-univ-0003-800.jpg',
    'http://www.publicdomainpictures.net/pictures/110000/velka/french-house-in-winter.jpg',
    'http://www.publicdomainpictures.net/pictures/40000/velka/cabana-rest-house-2.jpg',
    'http://www.publicdomainpictures.net/pictures/20000/velka/olld-house.jpg',
    'http://www.publicdomainpictures.net/pictures/10000/velka/brick-house-23441281560280c2Ja.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/1/11/97Burano.JPG',
    'https://upload.wikimedia.org/wikipedia/commons/a/a1/A_haveli_in_Mandawa.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/AdamsCarrolltonOrangeYouHappyHouse.JPG',
    'https://upload.wikimedia.org/wikipedia/commons/e/e0/AlgiersNOLAColorfulHousePorchSale.JPG',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/AWO_in_Bad_Salzdetfurth.jpg/2880px-AWO_in_Bad_Salzdetfurth.jpg',
  ]

  attr_accessor :distance
  belongs_to :user
  has_many :transactions
  has_many :unavailabilities, inverse_of: :litter_box
  has_many :ratings, through: :transactions
  accepts_nested_attributes_for :unavailabilities, allow_destroy: true

  validates :user_id, presence: true, uniqueness: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :capacity, :presence => true, :numericality => {:greater_than => 0}

  has_attached_file :photo, default_url: lambda { |av| STOCK_PHOTOS[av.instance.id % STOCK_PHOTOS.length] }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment :photo, size: { in: 0..500.kilobytes }

  def average_rating
    r = ratings

    unless (r.blank?)
      return (r.sum(:paws) / r.count.to_f).round
    end

    0
  end

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
    hash.merge!(
      distance: distance,
      full_address: full_address,
      photo_url: photo.url,
      average_rating: average_rating,
      number_of_ratings: ratings.count
    )
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
