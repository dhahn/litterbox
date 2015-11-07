class Rating < ActiveRecord::Base
	belongs_to :rater, foreign_key: :rater_id, class_name: User
	belongs_to :ratee, foreign_key: :ratee_id, class_name: User
end