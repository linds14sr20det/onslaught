class RoundAggregate < ApplicationRecord
	has_many :round_individual, inverse_of: :round_aggregate
	has_one :player, inverse_of: :round_aggregate
	has_one :opponent, inverse_of: :round_aggregate
	has_one :system, inverse_of: :round_aggregate
end