class AddPairings < ActiveRecord::Migration[5.0]
  def change
  	create_table :pairings do |t|
    	t.references :player_one, index: true, foreign_key:{to_table: :registrants}
    	t.references :player_two, index: true, foreign_key:{to_table: :registrants}
    	t.belongs_to :system
    	t.integer :round
    end
  end
end
