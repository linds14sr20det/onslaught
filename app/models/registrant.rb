class Registrant < ApplicationRecord
  belongs_to :system

  scope :paid, -> { where(paid: true) }
  scope :failed_payment, -> { where(paid: false) }

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
end
