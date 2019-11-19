class Event < ApplicationRecord
  after_initialize :default_values
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user

  has_many :inscriptions
  has_many :groups
  has_many :requisite_events

  private
    def default_values
      self.active ||= true
      self.need_additional ||= false
      self.status ||= "waiting"
    end
end
