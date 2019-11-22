class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :requisite
end
