class AddPaymentIdToRegistrant < ActiveRecord::Migration[5.0]
  def change
    add_column :registrants, :payment_id, :string
  end
end
