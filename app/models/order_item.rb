class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  def self.exist?(order_id, menu_item_id)
    find_by("order_id = ? and menu_item_id = ?",
            order_id,
            menu_item_id)
  end
end
