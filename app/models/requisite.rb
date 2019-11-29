class Requisite < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  has_many :requisite_events
  has_many :pills
end
