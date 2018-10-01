class RoundIndividual < ApplicationRecord
	has_one :player, inverse_of: :round_individual
	has_one :opponent, inverse_of: :round_individual
	has_one :system, inverse_of: :round_individual
	has_one :round_aggregate,  inverse_of: :round_individual
end