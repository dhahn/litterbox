class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :litter_box

  validates :user_id, :litter_box_id, presence: true

  validate :no_overlap_per_litter_box

  def self.overlaps(check_in, check_out)
    where "((check_in <= ?) and (check_out >= ?))", check_out, check_in
  end

  def self.non_overlapping(check_in, check_out)
    where.not(id: overlaps(check_in, check_out))
  end

  private

  def overlaps?
    siblings.overlaps(check_in, check_out).exists?
  end

  def siblings
    litter_box.transactions.where.not(id: id)
  end

  def no_overlap_per_litter_box
    if litter_box && overlaps?
      errors.add(:litter_box, 'Box already booked during given time')
    end
  end
end
