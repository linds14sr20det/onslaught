class AddCurrentRoundToSystem < ActiveRecord::Migration[5.0]
  def change
  	add_column :systems, :current_round, :integer
  end
end
