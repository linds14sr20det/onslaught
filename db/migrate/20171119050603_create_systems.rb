class CreateSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
      t.string :title
      t.string :descriptive_date
      t.string :description
      t.integer :max_players
      t.integer :cost

      t.timestamps
    end
  end
end
