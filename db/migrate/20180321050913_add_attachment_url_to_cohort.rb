class AddAttachmentUrlToCohort < ActiveRecord::Migration[5.0]
  def change
    add_column :cohorts, :attachment_url, :string
  end
end
