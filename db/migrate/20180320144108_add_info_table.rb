class AddInfoTable < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :body
      t.timestamps
    end
  end
end
