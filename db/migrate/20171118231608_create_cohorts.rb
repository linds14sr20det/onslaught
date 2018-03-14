class CreateCohorts < ActiveRecord::Migration[5.0]
  def change
    create_table :cohorts do |t|
      t.timestamp :start_at
      t.timestamp :end_at
      t.string :descriptive_date
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
