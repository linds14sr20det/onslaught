class AddStartDateToSystem < ActiveRecord::Migration[5.0]
  def change
    add_column :systems, :start_date, :timestamp
  end
end
