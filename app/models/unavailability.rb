class Unavailability < ActiveRecord::Base
  belongs_to :litter_box
  validates :litter_box, presence: true

  validate :valid_time_range

  def self.overlaps(start_time, end_time)
    where "((start_time <= ?) and (end_time >= ?))", end_time, start_time
  end

  def self.non_overlapping(start_time, end_time)
    where.not(id: overlaps(start_time, end_time))
  end

  private

  def valid_time_range
    if start_time && end_time && start_time > end_time
      errors.add(:end_time, 'must come after start_time')
    end
  end
end
