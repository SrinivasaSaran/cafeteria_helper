class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items do |t|
      t.bigint :menu_id
      t.string :name
      t.string :description
      t.float :price
      t.float :rating
    end
  end
end
