class AddAggregateForeignKeyToRoundIndividual < ActiveRecord::Migration[5.0]
  def change
  	add_reference :round_individual, :round_aggregate, index: true
  	add_foreign_key :round_individual, :round_aggregate
  end
end
