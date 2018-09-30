class AddRoundCountToSystem < ActiveRecord::Migration[5.0]
  def change
  	add_column :systems, :rounds, :integer
  end
end
