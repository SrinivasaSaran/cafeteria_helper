class AddQuantityToOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :quantity, :integer
    add_column :order_items, :quantity, :int
  end
end
