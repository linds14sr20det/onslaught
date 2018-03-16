class AddUuidToRegistrant < ActiveRecord::Migration[5.0]
  def change
    add_column :registrants, :uuid, :string
  end
end
