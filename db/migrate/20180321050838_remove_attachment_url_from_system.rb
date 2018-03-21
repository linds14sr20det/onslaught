class RemoveAttachmentUrlFromSystem < ActiveRecord::Migration[5.0]
  def change
    remove_column :systems, :attachment_url
  end
end
