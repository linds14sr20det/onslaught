class Pairing < ApplicationRecord
  belongs_to :system, inverse_of: :pairings
  has_one :player_one, inverse_of: :pairing
  has_one :player_two, inverse_of: :pairing
  validates :round, presence: true

  scope :round, -> (round_number) { where(round: round_number) }

end
