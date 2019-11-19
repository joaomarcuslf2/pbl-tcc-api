class RequisiteEvent < ApplicationRecord
  belongs_to :event
  belongs_to :requisite
end
