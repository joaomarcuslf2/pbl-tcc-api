class Group < ApplicationRecord
  has_many :inscriptions
  belongs_to :event
end
