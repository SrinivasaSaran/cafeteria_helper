class AddDetailsToMenuItems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :active_status, :boolean
  end
end
