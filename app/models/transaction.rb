class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :litter_box
end
