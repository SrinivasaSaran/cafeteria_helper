class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.boolean :active_status
      t.timestamps
    end
  end
end
