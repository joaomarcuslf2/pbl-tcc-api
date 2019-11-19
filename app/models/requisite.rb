class Requisite < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  has_many :requisite_events
end
