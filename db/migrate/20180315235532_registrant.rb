class Registrants < ActiveRecord::Migration[5.0]
  def change
    create_table :registrants do |t|
      t.string :name
      t.string :email
      t.boolean :paid
      t.belongs_to :system

      t.timestamps
    end
  end
end
