class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :booking_transaction, foreign_key: :transaction_id, class_name: Transaction
end