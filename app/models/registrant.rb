class Registrant < ApplicationRecord
  belongs_to :system

  scope :paid, -> { where(paid: true) }
  scope :failed_payment, -> { where(paid: false) }
end
