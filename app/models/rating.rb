class Rating < ActiveRecord::Base
	belongs_to :cattribute
  has_and_belongs_to_many :users
  has_and_belongs_to_many :cats

  def user
    users.first
  end

  def cat
    cats.first
  end
end
