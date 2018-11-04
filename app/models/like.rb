class Like < ApplicationRecord
  belongs_to :user
  belongs_to :shout
  # to match unique db constraint 
  validates :user_id, uniqueness: { scope: :shout_id }
end
