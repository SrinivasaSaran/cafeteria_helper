class RemoveDateFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :date, :date
    add_column :orders, :placed_at, :datetime
  end
end
