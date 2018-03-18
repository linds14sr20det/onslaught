class AddAttachmentToSystem < ActiveRecord::Migration[5.0]
  def change
    add_column :systems, :attachment_url, :string
  end
end
