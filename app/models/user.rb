class User < ApplicationRecord
  after_initialize :default_values
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  has_many :events

  def events_count
    self.events.count
  end

  def events_own
    Event.where(user_id: self.id)
  end

  private
    def default_values
      self.role ||= "user"
    end
end
