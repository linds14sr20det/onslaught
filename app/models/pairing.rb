class Pairing < ApplicationRecord
  belongs_to :system, inverse_of: :pairings
  belongs_to :player_one, class_name: "Registrant", :foreign_key => 'player_one_id'
  belongs_to :player_two, class_name: "Registrant", :foreign_key => 'player_two_id'
  validates :round, presence: true

  scope :round, -> (round_number) { where(round: round_number) }

end
